//
//  PostMapper.swift
//  MVVMRxSwift
//
//  Created by admin on 10/22/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import Foundation
import ObjectMapper

class PostMapper: Mappable {
    
    var userID: Int?
    var id: Int?
    var title: String?
    var body: String?
    
    /* Constructors */
    init?() {
        // Empty Constructor
    }
    // check before return object
    required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    
    func mapping(map: Map) {
        id <- map["id"]
        userID <- map["userId"]
        title <- map["title"]
        body <- map["body"]
    }
    
   
}
