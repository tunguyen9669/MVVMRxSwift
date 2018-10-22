//
//  PostServices.swift
//  MVVMRxSwift
//
//  Created by admin on 10/21/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import ObjectMapper


//, completion: @escaping (Result<[PostsDTO]>)
class PostServices: APIServiceObject{

    let disposeBag = DisposeBag()
    
    func getPosts(_ term: String) -> Void {
        let request = APIRequestProvider.shareInstance.getDataResult(term)
        let observable = serviceAgent.startRequest(request)
        
        observable.subscribe(onNext: { (jsonRespone) in
            var posts = [PostMapper]()
            var postNews = [PostNew]()
//            print(jsonRespone)
            guard let jsonArray = jsonRespone.arrayObject else {
                print("json nil")
                return
            }
            for json in jsonArray {
                if let item = json as? [String: AnyObject] {
                    if let postJSON = item as? [String: AnyObject],
                        let post = PostMapper(JSON: postJSON) {
                            posts.append(post)
                            print(posts[0].body ?? "")
                            print("\n")
                        for postItem in posts {
                            postNews.append(PostNew(postItem))
                            print(postNews[0].body ?? "")
                        }
                    }
                }
            }
        
          
//                var posts = [PostsDTO]()
//                for item in jsonRespone.arrayValue {
//                        posts.append(PostsDTO(item))
//                    print(item["body"])
//                }

            
            // mapper
//            guard let responeJson =  as? [String: AnyObject] else {
//                failure(0,"Error reading response")
//                return
//            }
//            let customer = Mapper<Customer>().map(JSONObject: responseJSON)

        }, onError: { (error) in
            print("Request error - PostService")
        }, onCompleted: {
            print("Request completed - PostService")
        }, onDisposed: {
            print("Request disposed - PostService")
        }).disposed(by: disposeBag)
//        serviceAgent.startRequest(request) { (json, error) in
//            if let error = error {
//                completion(Result.failure(error))
//            } else {
//                var posts = [PostsDTO]()
//                for item in json.arrayValue {
//                    posts.append(PostsDTO(item))
//                }
//                completion(Result.success(posts))
//            }
//        }
    }
    
    
}

