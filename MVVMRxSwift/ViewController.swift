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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        // Do any additional setup after loading the view, typically from a nib.
    }


}

