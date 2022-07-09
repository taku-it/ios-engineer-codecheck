//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryViewController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var repositories: [Repository] = []
    var row: Int?
    var searchRepositoryModel = SearchRepositoryModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            guard let detailVC = segue.destination as? DetailViewController,
                  let index = row else { return }
            detailVC.repository = self.repositories[index]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
}

extension SearchRepositoryViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRepositoryModel.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text ?? ""
        searchRepositoryModel.searchRepositories(query: query) {
            [weak self] (repositories) in
            self?.repositories = repositories
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
}
