//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var stargazersLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    
    var repository: Repository?
    func inject(repository: Repository) {
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let repository = repository else { return }
        
        languageLabel.text = "Written in \(repository.language ?? "")"
        stargazersLabel.text = "\(repository.stargazersCount) stars"
        watchersLabel.text = "\(repository.watchersCount) watchers"
        forksLabel.text = "\(repository.forksCount) forks"
        issuesLabel.text = "\(repository.openIssuesCount) open issues"
        titleLabel.text = repository.fullName
        getImage()
        
    }
    
    func getImage() {
        guard let repository = repository else { return }
        imageView.sd_setImage(with: URL(string: repository.owner.avatarUrl), completed: nil)
    }
    
}
