//
//  PostNew.swift
//  MVVMRxSwift
//
//  Created by admin on 10/22/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation

class PostNew: NSObject {
    var userID: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    init(_ mapper: PostMapper) {
        self.userID = mapper.userID
        self.id = mapper.id
        self.body = mapper.body
        self.title = mapper.title
    }
}
