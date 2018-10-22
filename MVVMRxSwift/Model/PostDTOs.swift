//
//  PostDTOs.swift
//  MVVMRxSwift
//
//  Created by admin on 10/21/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import SwiftyJSON

class PostsDTO {
    var userID: Int
    var id: Int
    var title: String
    var body: String
    
    init(_ json: JSON) {
        self.userID = json["userId"].intValue
        self.id = json["id"].intValue
        self.title = json["title"].stringValue
        self.body = json["body"].stringValue
    }
}
