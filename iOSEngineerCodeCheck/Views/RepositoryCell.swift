//
//  RepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/13.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    func configure(repository: Repository) {
        let avatarUrl = repository.owner.avatarUrl
        let fullName = repository.fullName
        let description = repository.description
        
        avatarImageView.sd_setImage(with: URL(string: avatarUrl), completed: nil)
        fullNameLabel.text = fullName
        descriptionLabel.text = description
        
    }
    
}
