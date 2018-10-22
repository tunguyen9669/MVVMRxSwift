//
//  Utilities.swift
//  MVVMRxSwiftExample
//
//  Created by admin on 10/19/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation

final class Utilities {
    static func createData() -> [SuperStar] {
        let ronaldo = SuperStar(name: "Cristiano Ronaldo", club: "Real Madrid", avatar: "boss")
        let messi = SuperStar(name: "Leonel Messi", club: "Barcelona", avatar: "boss")
        let torres = SuperStar(name: "Fernando Torres", club: "Atletico Madrid", avatar: "boss")
        return [ronaldo, messi, torres]
    }
    static func createClubData() -> [Club] {
        let juve = Club(club: "Juventus")
        let barca = Club(club: "Barcelona")
        let atletico = Club(club: "Aletico Madrid")
        return [juve, barca, atletico]
    }
}
