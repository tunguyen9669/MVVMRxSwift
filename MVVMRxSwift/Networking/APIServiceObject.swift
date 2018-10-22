//
//  APIServiceObject.swift
//  MVVMRxSwift
//
//  Created by admin on 10/21/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import Alamofire

class APIServiceObject: NSObject {
    var requests = [DataRequest]()
    var uploadRequests = [UploadRequest]()
    var serviceAgent = APIServiceAgent()
    func cancelAllRequests() {
        let sessionManager = Alamofire.SessionManager.default
        if #available(iOS 9.0, *) {
            sessionManager.session.getAllTasks { (_ tasks: [URLSessionTask]) in
                for task in tasks {
                    task.cancel()
                }
            }
        } else {
            // Fallback on earlier versions
            sessionManager.session
                .getTasksWithCompletionHandler({ (sessionTasks, uploadTasks, downloadTasks) in
                    for task in sessionTasks {
                        task.cancel()
                    }
                    for task in uploadTasks {
                        task.cancel()
                    }
                    for task in downloadTasks {
                        task.cancel()
                    }
                })
        }
        for request in requests {
            request.cancel()
        }
        requests.removeAll()
    }
    /*
     *  add request to request array
     *  @param request  DataRequest
     */
    func addToQueue(_ request: DataRequest) {
        requests.append(request)
    }
    
    func addToQueueUpload(_ request: UploadRequest) {
        uploadRequests.append(request)
    }
}
