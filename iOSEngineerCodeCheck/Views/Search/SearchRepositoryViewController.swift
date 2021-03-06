//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import PKHUD

final class SearchRepositoryViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private var presenter: SearchRepositoryPresenterInput!
    func inject(presenter: SearchRepositoryPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        setupTableViewCell()
    }
    
    func setupTableViewCell() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepo
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as? RepositoryCell
        else { return UITableViewCell() }
        
        if let repository = presenter.repository(forRow: indexPath.row) {
            cell.configure(repository: repository)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didChangeText()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        presenter.didTapSearchButton(text: text)
    }
    
}

extension SearchRepositoryViewController: SearchRepositoryPresenterOutput {
    
    func hideHUD() {
        HUD.hide()
    }
    
    func displayProgress() {
        HUD.dimsBackground = false
        HUD.show(.progress)
    }
    
    func displayError(_ text: String) {
        HUD.dimsBackground = false
        HUD.flash(.labeledError(title: text, subtitle: ""), delay: 2)
    }
    
    func updateRepository(_ repositories: [Repository]) {
        tableView.reloadData()
    }
    
    func transitionToDetail(repository: Repository) {
        guard let detailVC =
                UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController
        else { return }
        detailVC.inject(repository: repository)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
