//
//  HomeViewController.swift
//  Assignment
//
//  Created by Neha on 17/04/24.
//

import UIKit

class HomeViewController: BaseViewController, CommontLoader {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var refreshControl = UIRefreshControl()
    var viewModel: HomeViewModel = HomeViewModelImp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setUpUI() {
        self.title = "Home" // to set navigation title
        setUpTableView()
        bind()
        showLocallyStoredData() // showing locally stored data irrespective of internet connectivity once the data fetched from BE tableview will get reload
        setUpRefreshControl()
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
          tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(BottomTitleTableViewCell.nib(), forCellReuseIdentifier: BottomTitleTableViewCell.identifier)
        tableView.register(CarouselTableViewCell.nib(), forCellReuseIdentifier: CarouselTableViewCell.identifier)
    }
    
    private func showLocallyStoredData() {
        viewModel.getDataForOflline()
        self.tableView.reloadData()
    }
    
    private func bind() {
        if isInternetConnected() {
            showLoading()
            viewModel.getCarouselData() // api call
        } else {
            self.showToast(message: "No Internet connectivity..")
        }
        
        viewModel.didFetchCarouselDataSucess = { [weak self] in //got success from api
            guard let weakSelf = self else { return }
            weakSelf.hideLoading()
            weakSelf.refreshControl.endRefreshing()
            weakSelf.tableView.reloadData()
        }
        viewModel.didFetchCarouselDataError = { [weak self] error in
            guard let weakSelf = self else { return }
            weakSelf.hideLoading()
            weakSelf.refreshControl.endRefreshing()
            weakSelf.showToast(message: error.localizedDescription)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            return
        } else {
            let vc = UIViewController.detailVC
            vc.detail = self.viewModel.newsDetailList?[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarouselTableViewCell.identifier, for: indexPath) as? CarouselTableViewCell else { return UITableViewCell() }
            if let model = viewModel.newsDetailList {
                cell.listOfImages = viewModel.newsDetailList
                cell.pageControl.numberOfPages = model.count >= 5 ? 5 : model.count
            }
            return cell
        } else if indexPath.section == 1 {
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomTitleTableViewCell.identifier, for: indexPath) as? BottomTitleTableViewCell else { return UITableViewCell() }
            if let model = self.viewModel.newsDetailList?[indexPath.row] {
                cell.configureUI(model)
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return viewModel.newsDetailList?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 || section == 2 {
            return nil
        }
        let view = SearchBarCustomView.loadView()
        view.delegate = self
        view.configureUI()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 2 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 0
        }
        return UITableView.automaticDimension
    }
    
}
extension HomeViewController: SearchBarCustomViewDelegate {
    func didChangeCharaterInSearchField(_ text: String) {
        self.viewModel.filterOutFromList(text)
        self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
////        self.tableView.reloadData()
//        if let list = self.viewModel.newsDetailList {
//            for i in 0..<list.count {
//                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
////                self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
//            }
//        }
    }
    
    
}

extension HomeViewController {
    private func setUpRefreshControl() {
        self.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    @objc func pullToRefresh(_ sender: AnyObject) {
        refreshProfileData()
    }
    
    private func refreshProfileData() {
        if isInternetConnected() {
            viewModel.getCarouselData()
        } else {
            self.showToast(message: "No Internet connectivity..")
            refreshControl.endRefreshing()
        }
    }
}
