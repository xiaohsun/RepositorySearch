//
//  RepoListViewController.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit
import Combine

class RepoListViewController: UIViewController {
    
    let viewModel = RepoListViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    lazy var repoListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepoListTableViewCell.self, forCellReuseIdentifier: RepoListTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        searchBar.placeholder = "請輸入關鍵字搜尋"
        return searchBar
    }()
    
    private func addSearchBar() {
        repoListTableView.tableHeaderView = searchBar
    }
    
    private func setupUI() {
        view.addSubview(repoListTableView)
        
        NSLayoutConstraint.activate([
            repoListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            repoListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            repoListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            repoListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSearchBar()
        
        viewModel.fetchRepositories(query: "Swift")
        viewModel.repositories.sink { [weak self] _ in
            self?.repoListTableView.reloadData()
        }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Repository Search"
    }
}

extension RepoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepoListTableViewCell.reuseIdentifier, for: indexPath) as? RepoListTableViewCell else { return UITableViewCell() }
        cell.label.text = viewModel.repositories.value[indexPath.row].fullName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}
