//
//  FirstViewModel.swift
//  MVVMRxSwiftExample
//
//  Created by admin on 10/18/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FirstViewModel {
    // MARK: Properties
    // step 1: Take a look how many inputs in VC and declare amount of corresponding variables
    let disposeBag = DisposeBag()
    var inputText = Variable<String>("")
    var anotherInputText = Variable<String>("")
    let serviceAgent = APIServiceAgent()
    var arrPost = Variable<[PostNew]>([])
    let publishSubject = PublishSubject<String>()
  
    //step 3: VM processes Data from
    var textObservable: Observable<String> {
        // here is some logic code to handle requirement  then back data
        return Observable.combineLatest(inputText.asObservable(), anotherInputText.asObservable()) { input, anotherInput in
            if input == "" && anotherInput == "" {
                return "Hello"
            } else {
                return input + " and " + anotherInput
            }
        }
    }
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(inputText.asObservable(), anotherInputText.asObservable()) { input, anotherInput in
            return input.count >= 3 && anotherInput.count >= 3
        }
    }
    var sendKeyWord: Observable<String> {
        return inputText.asObservable()
    }
    
    func getPosts(_ term: String,_ completion: @escaping([PostNew]) -> Void) -> Void {
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
                        for postItem in posts {
                            postNews.append(PostNew(postItem))
                            print(postNews[0].body ?? "")
                            completion(postNews)
                            self.publishSubject.onNext("\(postNews[0].id)")
                        }
                    }
                }
            }
            
        }, onError: { (error) in
            print("Request error - PostService")
        }, onCompleted: {
            print("Request completed - PostService")
        }, onDisposed: {
            print("Request disposed - PostService")
        }).disposed(by: disposeBag)
    }
}
