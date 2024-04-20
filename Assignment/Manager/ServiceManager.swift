//
//  ServiceManager.swift
//  Assignment
//
//  Created by Neha on 20/04/24.
//

import Foundation
import UIKit
import Alamofire

protocol ServiceManager {
    func get(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void)
    func post(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void)
    func patch(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void)
    func upload(with url: String, imageData: Data?, parameters: [String : Any]?, withName: String?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void)
    func delete(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void)
    func uploadDocument(httpMethod: HTTPMethod, with url: String, imageData: [Data]?, imageDataKeyName: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void)
    func put(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void)
}

extension ServiceManager {
    func get(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void) {}
    func post(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void) {}
    func patch(with url: String, parameters: [String: Any]?, headers: [String: String]?, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void) {}
    func upload(with url: String, imageData: Data?, parameters: [String : Any]?, withName: String?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {}
    func delete(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {}
    func uploadDocument(httpMethod: HTTPMethod, with url: String, imageData: [Data]?, imageDataKeyName: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {}
    func put(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {}
}

struct ServiceManagerImp: ServiceManager {
    //Parse contents
    private let STATUS = "status"
    private let ERROR_SUCCESS_MESSAGES = "description"
    private let ERROR_FAILURE_MESSAGE = "message"
    
    //Public Methods
    
    func get(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        print("URL: \(url)")
        print("BODY: \(String(describing: parameters))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        
        let session = AF
        
        session.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: (headers != nil ? HTTPHeaders(headers!) : nil)).validate().responseData { response in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    func delete(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        print("URL: \(url)")
        print("BODY: \(String(describing: parameters))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        
        let session = AF
        
        session.request(url, method: .delete, parameters: parameters, encoding: URLEncoding.default, headers: (headers != nil ? HTTPHeaders(headers!) : nil)).validate().responseData { response in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    
    func post(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        print("URL: \(url)")
        print("BODY: \(String(describing: parameters))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        
        let session = AF
        
        session.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: (headers != nil ? HTTPHeaders(headers!) : nil)).validate().responseData { response in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    func put(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        print("URL: \(url)")
        print("BODY: \(String(describing: parameters))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        
        let session = AF
        
        session.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: (headers != nil ? HTTPHeaders(headers!) : nil)).validate().responseData { response in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    func patch(with url: String, parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        print("URL: \(url)")
        print("BODY: \(String(describing: parameters))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        
        let session = AF
        
        session.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: (headers != nil ? HTTPHeaders(headers!) : nil)).validate().responseData { response in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    func upload(with url: String, imageData: Data?, parameters: [String : Any]?, withName: String? = "image", headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            let error = DError(code: .unknown)
            failure(error)
            return
        }
        
        print("URL: \(url)")
//        print("ImageData: \(String(describing: requestModel.imageData))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        let session = AF
//        let mimeType = "image/jpeg"
//        var mediatype = ""
        let request = session.upload(
            multipartFormData: { multipartFormData in
               
                for (key,value) in parameters! {
                    print("KEYYY:", key, " .." ,value)
                    
                    if let value = value as? String {
//                        mediatype = value
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                    if let value = value as? Int {
                        multipartFormData.append(value.description.data(using: .utf8)!, withName: key)
                    }
                    if let value = value as? Double {
                        multipartFormData.append(value.description.data(using: .utf8)!, withName: key)
                    }
                }
                if let imageData = imageData {
                    print("IMageDATA", imageData)
                    multipartFormData.append(imageData, withName: withName!, fileName: "\(withName!).png", mimeType: "\(withName!)/png")
                }
//                multipartFormData.append(requestModel.imageData, withName: "image", fileName: "images", mimeType: "image/jpeg")
//                multipartFormData.append(requestModel.frameColor.data(using: .utf8)!, withName: "frameColor")
//                multipartFormData.append(requestModel.frameSize.description.data(using: .utf8)!, withName: "frameSize")
//                multipartFormData.append(requestModel.frameType.data(using: .utf8)!, withName: "frameType")

            },
            to: url,
            usingThreshold: UInt64.init(),
            method: .post,
            headers: (headers != nil ? HTTPHeaders(headers!) : nil))
        request.responseString { (response: AFDataResponse<String>) in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    func uploadDocument(httpMethod: HTTPMethod, with url: String, imageData: [Data]?, imageDataKeyName: String = "images", parameters: [String : Any]?, headers: [String : String]?, success: @escaping ([String : Any]?) -> Void, failure: @escaping (DError) -> Void) {
        guard let url = URL(string: url) else {
            let error = DError(code: .unknown)
            failure(error)
            return
        }
        
        print("URL: \(url)")
//        print("ImageData: \(String(describing: requestModel.imageData))")
        if let headers = headers {
            print("HEADER: \(headers)")
        }
        let session = AF
        let request = session.upload(
            multipartFormData: { multipartFormData in
                
                for (key,value) in parameters! {
                    print("KEYYY:", key, " .." ,value)
                    
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: .utf8)!, withName: key)
                    }
                    if let value = value as? Int {
                        multipartFormData.append(value.description.data(using: .utf8)!, withName: key)
                    }
                    if let value = value as? Double {
                        multipartFormData.append(value.description.data(using: .utf8)!, withName: key)
                    }
                    
                    if let value = value as? [Int] {
                        for item in value {
                            multipartFormData.append(item.description.data(using: .utf8)!, withName: key)
                        }
                    }
                   
                }
                if let imageData = imageData {
                    for data in imageData {
                        multipartFormData.append(data, withName: imageDataKeyName, fileName: "images.png", mimeType: "image/jpeg")
                    }
                }
//                let vx = "; filename=\"\(paramSrc)\"\r\n"
//                      + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
//                multipartFormData.append(requestModel.imageData, withName: "image", fileName: "images", mimeType: "image/jpeg")
//                multipartFormData.append(requestModel.frameColor.data(using: .utf8)!, withName: "frameColor")
//                multipartFormData.append(requestModel.frameSize.description.data(using: .utf8)!, withName: "frameSize")
//                multipartFormData.append(requestModel.frameType.data(using: .utf8)!, withName: "frameType")

            },
            to: url,
            usingThreshold: UInt64.init(),
            method: httpMethod,
            headers: (headers != nil ? HTTPHeaders(headers!) : nil))
        request.responseString { (response: AFDataResponse<String>) in
            dispatchConditionally(with: response, success: success, failure: failure)
        }
    }
    
    
    
    
}

extension ServiceManagerImp {
    
    private func parseGatewayError(for code: Int) -> GatewayError {
        let errorCode = "\(code)"
        let error = GatewayError(code: HTTPErrorCode(rawValue: errorCode) ?? .unknown)
        return error
    }
    
    private func dispatchConditionally(with response: AFDataResponse<String>, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void) {
        switch response.result {
        case .success:
            if let data = response.data, let json = convertToDictionary(data) {
//                guard (json[STATUS] as? String) == "success" else {
//                    let apiError = self.parseAPIErrorForSuccess(-1, json)
//                    failure(apiError)
//                    return
//                }
                success(json)
            } else {
                let apiError = DError(code: .unknown, message: nil)
                failure(apiError)
            }
            
        case .failure(let error):
            let isServerTrustEvaluationError = error.asAFError?.isServerTrustEvaluationError ?? false
            if isServerTrustEvaluationError {
                failure(DError(code: .pinningFail))
            } else {
                if let data = response.data, let json = convertToDictionary(data) {
                    let apiError = self.parseAPIErrorForFailur(-1, json)
                    failure(apiError)
                } else {
                    let apiError = DError(code: .unknown, message: nil)
                    failure(apiError)
                }
                
            }
        }
    }
    private func dispatchConditionally(with response: AFDataResponse<Data>, success: @escaping ([String: Any]?) -> Void, failure: @escaping (DError) -> Void) {
        switch response.result {
        case .success:
            if let data = response.data, let json = convertToDictionary(data), let code = response.response?.statusCode, code == 200 {
                print(json)
                if let status = json[STATUS] as? String, status != "ok", let json = convertToDictionary(data) {
                    let apiError = self.parseAPIErrorForFailur(-1, json)
                    failure(apiError)
                } else if let errorCode = json[STATUS] as? String, errorCode == "error" {
                    let json = [ERROR_FAILURE_MESSAGE: errorCode]
                    let apiError = self.parseAPIErrorForFailur(-1, json)
                    failure(apiError)
                } else {
                    success(json)
                }
//                guard (json[STATUS] as? String) == "success" else {
//                    let apiError = self.parseAPIErrorForSuccess(-1, json)
//                    failure(apiError)
//                    return
//                }
//                success(json)
            } 
            
        case .failure(let error):
            let isServerTrustEvaluationError = error.asAFError?.isServerTrustEvaluationError ?? false
            if isServerTrustEvaluationError {
                failure(DError(code: .pinningFail))
            } else {
                if let data = response.data, let json = convertToDictionary(data) {
                    print(json)
                    let apiError = self.parseAPIErrorForFailur(-1, json)
                    failure(apiError)
                } else {
                    let apiError = DError(code: .unknown, message: nil)
                    failure(apiError)
                }
                
            }
        }
    }
    
    private func parseAPIErrorForSuccess(_ code: Int, _ responseMap: [String: Any]) -> DError {
//        if let errorMessage = responseMap[ERROR_MESSAGES] as? String, errorMessage != "" {
//            let errorCode: String = "\(code)"
//            var error = DError(code: ErrorCode(rawValue: errorCode) ?? .unknown)
//            error.message = errorMessage
//            return error
//        }
        if let errorMessage = responseMap[ERROR_SUCCESS_MESSAGES] as? String {
            let errorCode: String = "\(code)"
            var error = DError(code: ErrorCode(rawValue: errorCode) ?? .unknown)
            error.message = errorMessage
            return error
        }
        
        let apiError = DError(code: ErrorCode(rawValue: "\(code)") ?? .unknown)
        return apiError
        
    }
    private func parseAPIErrorForFailur(_ code: Int, _ responseMap: [String: Any]) -> DError {
//        if let errorMessage = responseMap[ERROR_MESSAGES] as? String, errorMessage != "" {
//            let errorCode: String = "\(code)"
//            var error = DError(code: ErrorCode(rawValue: errorCode) ?? .unknown)
//            error.message = errorMessage
//            return error
//        }
        if let errorMessage = responseMap[ERROR_FAILURE_MESSAGE] as? String {
            let errorCode: String = "\(code)"
            var error = DError(code: ErrorCode(rawValue: errorCode) ?? .unknown)
            error.message = errorMessage
            return error
        }
        
        let apiError = DError(code: ErrorCode(rawValue: "\(code)") ?? .unknown)
        return apiError
        
    }
    
    func convertToDictionary(_ data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            return json
        } catch {
            return nil
        }
    }
    
    func convertToArray(_ data: Data) -> [Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any]
            return json
        } catch {
            return nil
        }
    }
    
}


