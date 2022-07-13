//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

final class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var stargazersLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var repository: Repository?
    func inject(repository: Repository) {
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getImage()
    }
    
    func setup() {
        guard let repository = repository else { return }
        languageLabel.text = "Written in \(repository.language ?? "")"
        stargazersLabel.text = "stars \(repository.stargazersCount)"
        watchersLabel.text = "watchers \(repository.watchersCount)"
        forksLabel.text = "forks \(repository.forksCount)"
        issuesLabel.text = "open issues \(repository.openIssuesCount)"
        titleLabel.text = repository.fullName
        descriptionLabel.text = repository.description
    }
    
    func getImage() {
        guard let repository = repository else { return }
        imageView.sd_setImage(with: URL(string: repository.owner.avatarUrl), completed: nil)
    }
    
}
