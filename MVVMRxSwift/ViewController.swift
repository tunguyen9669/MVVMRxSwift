//
//  ViewController.swift
//  MVVMRxSwiftExample
//
//  Created by admin on 10/18/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

// bind VC and VM
class ViewController: UIViewController {
    // MARK: - Outlets and Variables
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var inputTextField2: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    let firstViewModel = FirstViewModel()
    let disposeBag = DisposeBag()
    let service = PostServices()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // net working
//        firstViewModel.getPosts("1") { data in
//            print(data[0].id ?? "")
//        }
//        firstViewModel.getPosts("2") { (data) in
//            print(data[0].id ?? "")
//        }
//        // observable example
//        observableExample()
//
//        // publish subject
//        publishExample()
        
        // behavior subject
//        behaviorSubject()
        // replay subject
        replaySubject()
        
        
        
      
    }
    func replaySubject() {
        // kiểm soát số lượng onNext, đăng kí số lượng subcribe, trước chỉ nhận 2 cái. sau có bao nhiêu nhận hết
        let bag = DisposeBag()
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2) //khởi tạo một ReplaySubject kiểu String với size của buffer là 2
        
        replaySubject.onNext("Emit 1") //Phát ra một emit với String "Emit 1"
        replaySubject.onNext("Emit 2") //Phát ra một emit với String "Emit 2"
        replaySubject.onNext("Emit 3") //Phát ra một emit với String "Emit 3"
        
        print("- Before subscribe -")
        let subscriber = replaySubject.subscribe { element in
            print("Subscriber 1: \(element)")
        }
        subscriber.disposed(by: bag)
        print("- After subscribe -")
        
        replaySubject.onNext("Emit 4")
        replaySubject.onNext("Emit 5")
        replaySubject.onNext("Emit 6")
        
        print("- Before subscribe -")
        let subscriberSecond = replaySubject.subscribe { element in
            print("Subscriber 2: \(element)")
        }
        subscriberSecond.disposed(by: bag)
        print("- After subscribe -")
        replaySubject.onNext("Emit 7")
        replaySubject.onNext("Emit 8")
        replaySubject.onNext("Emit 9")
    }
    
    func behaviorSubject() {
        // đưa ra các giá trị gần nhất, nếu onnext trc subcribe thì chỉ lấy 1 giá trị onNext
        let bag = DisposeBag()
        let behaviorSubject = BehaviorSubject<String>(value: "Initial Value")
        behaviorSubject.onNext("Emit 1")
        
        print("- Subscribe here -")
        let subscriber = behaviorSubject.subscribe { element in
            print("Subscriber 1: \(element)")
        }
        subscriber.disposed(by: bag)
        
        behaviorSubject.onNext("Emit 2")
        behaviorSubject.onNext("Emit 3")
        
        let subcriberSecond = behaviorSubject.subscribe { element in
            print("Subscriber 2: \(element)")
        }
        subcriberSecond.disposed(by: bag)

        behaviorSubject.onNext("Emit 4")
        behaviorSubject.onNext("Emit 5")
        
        let subcriberThird = behaviorSubject.subscribe { element in
            print("Subscriber 3: \(element)")
        }
        subcriberThird.disposed(by: bag)
    }
    
    func publishExample() {
       // nếu có lệnh onNext trc khi 1 biến subcribe để lắng nghe đc khởi tạo thì sẽ k có giá trị từ lệnh onNext đó
        let subscriberOne = firstViewModel.publishSubject.subscribe { element in
            print("subscriber 1: \(element)")
        }
        subscriberOne.disposed(by: disposeBag)
        print("- - - - - - -")
        let subscriberTwo = firstViewModel.publishSubject.subscribe { element in //tạo ra một Subscriber mới
            print("subscriber 2: \(element)")
        }
        subscriberTwo.disposed(by: disposeBag)
    }
    
    func observableExample() {
        // step 2: VM receives signals/ data of UI from VC
        inputTextField.rx.text.map {$0 ?? ""}
            .bind(to: firstViewModel.inputText)
            .disposed(by: disposeBag)
        
        inputTextField2.rx.text.map {$0 ?? ""}
            .bind(to: firstViewModel.anotherInputText)
            .disposed(by: disposeBag)
        
        // step 4: VC subcribes observable that VM provides
        firstViewModel.textObservable.subscribe(onNext: { text in
            self.displayLabel.text = text
        }).disposed(by: disposeBag)
        
        firstViewModel.isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        self.firstViewModel.isValid.subscribe(onNext:  { isValid in
            print(isValid)
        }).disposed(by: disposeBag)
        
        firstViewModel.sendKeyWord.subscribe(onNext: { keyWord in
            self.firstViewModel.getPosts(keyWord, { (data) in
                print("Update data")
            })
        }).disposed(by: disposeBag)
        
    }

}

