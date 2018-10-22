//
//  APIServiceAgent.swift
//  MVVMRxSwift
//
//  Created by admin on 10/21/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import CFNetwork
import RxSwift

class APIServiceAgent: NSObject {
typealias ResponseData = Observable<JSON>
    func startRequest(_ request: DataRequest) -> (Observable<JSON>) {
        return Observable.create({ (observer) -> Disposable in
           let requestAction = request
                .responseJSON { (response: DataResponse<Any>) in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        observer.onNext(json)
                        observer.onCompleted()
                    case .failure(let error as NSError):
                        observer.onError(NSError(domain: "myDomain", code: -1, userInfo: nil))
                        print(error)
                        break
                    }
            }
            return Disposables.create {
                requestAction.cancel()
            }
        })
      
    }
}
