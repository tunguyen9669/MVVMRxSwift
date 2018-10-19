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
    var inputText = Variable<String>("")
    var anotherInputText = Variable<String>("")
    var arr = Variable<[String]>([])
    var array: [String] = ["TuND"]
    
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
    
    var sendArr: Observable<[String]> {
        return arr.asObservable()
    }
}
