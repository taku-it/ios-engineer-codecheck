//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController2: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var TtlLbl: UILabel!
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var repository: Repository?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let repository = repository else { return }
        
        LangLbl.text = "Written in \(repository.language)"
        StrsLbl.text = "\(repository.stargazersCount) stars"
        WchsLbl.text = "\(repository.watchersCount) watchers"
        FrksLbl.text = "\(repository.forksCount) forks"
        IsssLbl.text = "\(repository.openIssuesCount) open issues"
        TtlLbl.text = repository.fullName
        getImage()
        
    }
    
    func getImage(){
        guard let repository = repository else { return }
                ImgView.sd_setImage(with: URL(string: repository.owner.avatarUrl), completed: nil)
    }
    
}
