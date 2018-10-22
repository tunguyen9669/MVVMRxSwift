//
//  APIRequestProvider.swift
//  MVVMRxSwift
//
//  Created by admin on 10/21/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation

import Alamofire
import SwiftyJSON

class APIRequestProvider: NSObject {
    // MARK: variable
    let url = "https://api.imgur.com/3/image" /* your API url */
    var _headers: HTTPHeaders = [:]
    var headers: HTTPHeaders {
        set {
            _headers = headers
        }
        get {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer 5a2a7f6589cb6b83e51362cbf484836f741c93d9"
            ]
            return headers
        }
    }
    private var uploadImageUrl: String = "https://api.imgur.com/3/image"
    private var requestURL: String = "https://jsonplaceholder.typicode.com/posts"
    // MARK: SINGLETON
    static var shareInstance: APIRequestProvider = {
        let instance = APIRequestProvider()
        return instance
    }()
    var alamoFireManager: SessionManager
    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 120
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    // MARK: -- Authorization Requests
    func getDataResult(_ keyWord: String) -> DataRequest {
        var param = [String: Any]()
        param["id"] = keyWord
        return alamoFireManager.request(requestURL,
                                        method: .get,
                                        parameters: param,
                                        encoding: URLEncoding.default,
                                        headers: nil)
    }
    func uploadData(_ data: Data) -> UploadRequest {
        return alamoFireManager.upload(data,
                                       to: url,
                                       method: .post,
                                       headers: headers)
    }
}

