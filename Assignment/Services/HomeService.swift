//
//  HomeService.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation

protocol HomeService {
    func getBBCNewsDetails(requestModel: NewsRequestBody, success: @escaping (NewsResponse) -> Void, failure: @escaping (DError) -> Void)
}

struct HomeServiceImp: HomeService {
    
    private let serviceManager: ServiceManager
    private let DATA = "data"
    private let CODE = "response_code"
    
    init(serviceManager: ServiceManager = ServiceManagerImp()) {
        self.serviceManager = serviceManager
    }
    func getBBCNewsDetails(requestModel: NewsRequestBody, success: @escaping (NewsResponse) -> Void, failure: @escaping (DError) -> Void) {
        let url = Constants.BBC_NEWS.getToHeadlines
        do {
            let body = try requestModel.asDictionary()
            self.serviceManager.get(with: url, parameters: body, headers: httpHeaders()) { json in
                do {
                    guard let data = json else {
                        failure(DError(code: .unknown))
                        return
                    }
                    let model = try map(json: data, to: NewsResponse.self)
                    success(model)
                } catch let err {
                    failure(DError(code: .unknown, message: err.localizedDescription))
                }
            } failure: { error in
                failure(error)
            }
        } catch let err {
            failure(DError(code: .unknown, message: err.localizedDescription))
        }
    }
}


