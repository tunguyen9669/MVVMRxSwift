//
//  CustomTableViewHeader.swift
//  MVVMRxSwift
//
//  Created by admin on 10/19/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import UIKit

class CustomTableViewHeader: UITableViewHeaderFooterView {
    static var Identifier = "CustomTableViewHeader"
    @IBOutlet weak var clubLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var club: Club? {
        didSet {
            guard let club = club else { return }
            clubLabel.text = club.club
        }
    }

   
    
}
