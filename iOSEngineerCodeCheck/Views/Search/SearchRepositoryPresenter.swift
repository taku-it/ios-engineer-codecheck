//
//  SearchRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 生田拓登 on 2022/07/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import PKHUD

protocol SearchRepositoryPresenterInput {
    var numberOfRepo: Int { get }
    func repository(forRow row:Int) -> Repository?
    func didSelectRow(at indexPath: IndexPath)
    func didTapSearchButton(text: String?)
    func didChangeText()
}

protocol SearchRepositoryPresenterOutput: AnyObject {
    func updateRepository(_ repositories: [Repository])
    func displayError(_ title: String)
    func displayProgress()
    func hideHUD()
    func transitionToDetail(repository: Repository)
}

final class SearchRepositoryPresenter: SearchRepositoryPresenterInput {
    private var repositories: [Repository] = []
    
    private weak var view: SearchRepositoryPresenterOutput?
    private var model: SearchRepositoryModelInput
    
    init(view: SearchRepositoryPresenterOutput, model: SearchRepositoryModelInput) {
        self.view = view
        self.model = model
    }
    
    var numberOfRepo: Int {
        return repositories.count
    }
    
    func repository(forRow row: Int) -> Repository? {
        guard row < repositories.count else { return nil }
        return repositories[row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard let repository = repository(forRow: indexPath.row) else { return }
        view?.transitionToDetail(repository: repository)
    }
    
    func didTapSearchButton(text: String?) {
        guard let query = text else { return }
        
        if !query.isEmpty {
            view?.displayProgress()
            
            model.searchRepositories(query: query) { [weak self] result in
                switch result {
                case .success(let repositories):
                    self?.repositories = repositories
                    
                    DispatchQueue.main.async {
                        self?.view?.updateRepository(repositories)
                        self?.view?.hideHUD()
                    }
                case .failure(.connectionError):
                    self?.view?.displayError("通信に失敗しました")
                case .failure(.responseParseError):
                    self?.view?.displayError("データの解釈に失敗しました")
                case .failure(.apiError(let error)):
                    self?.view?.displayError(error.message)
                }
            }
        }
    }
    
    func didChangeText() {
        view?.hideHUD()
        model.cancel()
    }
    
}
