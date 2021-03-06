//
//  SuperStarViewModel.swift
//  MVVMRxSwiftExample
//
//  Created by admin on 10/19/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class SuperStarViewModel: NSObject {
    // private let disposeBag = DisposeBag()
    let superStars = Variable<[SuperStar]>([])
    let clubs = Variable<[Club]>([])
    
    override init() {
        superStars.value = Utilities.createData()
    }
    func getClub() {
        clubs.value = Utilities.createClubData()
    }
}
