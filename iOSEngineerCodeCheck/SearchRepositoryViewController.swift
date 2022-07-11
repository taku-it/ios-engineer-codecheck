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
    
    private var presenter: SearchRepositoryPresenterInput!
    func inject(presenter: SearchRepositoryPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepo
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = presenter.repository(forRow: indexPath.row)
        cell.textLabel?.text = repository?.fullName
        cell.detailTextLabel?.text = repository?.language
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
    
    func updateRepository() {
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
