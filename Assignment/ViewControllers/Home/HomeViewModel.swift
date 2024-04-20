//
//  HomeViewModel.swift
//  Assignment
//
//  Created by Neha on 18/04/24.
//

import UIKit

protocol HomeViewModel {
    var didFetchCarouselDataSucess: (() -> Void)? { get set }
    var didFetchCarouselDataError: ((DError) -> Void)? { get set }
    func getCarouselData()
    func filterOutFromList(_ text: String)
    
    var newsDetailList: [NewsArticleDetail]? { get }
    
    func getDataForOflline()
}

class HomeViewModelImp: HomeViewModel {
    var didFetchCarouselDataSucess: (() -> Void)?
    var didFetchCarouselDataError: ((DError) -> Void)?
    
    var originallistOfImages: [NewsArticleDetail]?
    var newsDetailList: [NewsArticleDetail]?
    
    func getCarouselData() {
        let body = NewsRequestBody(sources: "bbc-news", apiKey: Constants.API_KEY)
        HomeServiceImp().getBBCNewsDetails(requestModel: body) { [weak self] response in
            guard let weakSelf = self else { return }
            
            if let articles = response.articles, !articles.isEmpty { // data Available , save data in Database too
                weakSelf.newsDetailList = articles
                weakSelf.originallistOfImages = articles
                CachedData.shared.saveDataInDataBase(response.articles)
                
            } else { // fetch data from database if already saved
                weakSelf.newsDetailList = CachedData.shared.getDataInNewsDetailForm()
                weakSelf.originallistOfImages = CachedData.shared.getDataInNewsDetailForm()
            }
            weakSelf.didFetchCarouselDataSucess?()
            
        } failure: {[weak self] error in
            guard let weakSelf = self else { return }
            weakSelf.didFetchCarouselDataError?(error)
        }
        
    }
    
    func getDataForOflline() {
        self.newsDetailList = CachedData.shared.getDataInNewsDetailForm()
        self.originallistOfImages = CachedData.shared.getDataInNewsDetailForm()
    }
    
    func filterOutFromList(_ text: String) {
        self.newsDetailList = originallistOfImages?.filter({ model in
            if let desc = model.description, desc.contains(text) {
                return true
            }
            return false
        })
        
        if newsDetailList == nil || newsDetailList!.isEmpty {
            self.newsDetailList = originallistOfImages
        }
    }
}
