//
//  SuperStarViewController.swift
//  MVVMRxSwiftExample
//
//  Created by admin on 10/19/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SuperStarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = SuperStarViewModel()
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.bind()
        // Do any additional setup after loading the view.
    }
    private func registerCell() {
        let nib = UINib(nibName: CustomTableViewCell.Identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CustomTableViewCell.Identifier)
        
    }
    private func configureTableView() {
        registerCell()
    }
    private func bind() {
        viewModel.superStars.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CustomTableViewCell.Identifier, cellType: CustomTableViewCell.self)) {
                row, superStar, cell in
                cell.superStar = superStar
            }.disposed(by: dispose)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableView.cellForRow(at: indexPath) as? CustomTableViewCell
                print(cell?.superStar?.name ?? "")
            }).disposed(by: dispose)
    }


}
