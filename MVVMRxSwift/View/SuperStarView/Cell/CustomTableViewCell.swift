//
//  CustomTableViewCell.swift
//  MVVMRxSwiftExample
//
//  Created by admin on 10/19/18.
//  Copyright © 2018 admin.dinhtu. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static var Identifier = "CustomTableViewCell"
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    var superStar: SuperStar? {
        didSet {
            guard let superStar = superStar else { return }
            nameLabel.text = superStar.name
            clubLabel.text = superStar.club
            avatarImageView.image = UIImage(named: "\(superStar.avatar)")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
