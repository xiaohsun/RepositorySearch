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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        return tableView
    }()
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshToLoad), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        searchBar.placeholder = "請輸入關鍵字搜尋"
        searchBar.delegate = self
        return searchBar
    }()
    
    private func fetchData() {
        if let text = searchBar.text {
            viewModel.fetchRepositories(query: text)
            viewModel.repositories.sink { [weak self] _ in
                self?.repoListTableView.reloadData()
                self?.clearSearchBar()
                self?.refresher.endRefreshing()
            }.store(in: &cancellables)
        }
    }
    
    @objc private func refreshToLoad(){
        fetchData()
    }
    
    private func clearSearchBar() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    private func addSearchBar() {
        repoListTableView.tableHeaderView = searchBar
    }
    
    private func setUpRefresher() {
        repoListTableView.addSubview(refresher)
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
        setUpRefresher()
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
        let name = viewModel.repositories.value[indexPath.row].fullName
        let description = viewModel.repositories.value[indexPath.row].description
        let imageURL = viewModel.repositories.value[indexPath.row].owner.avatarURL
        cell.update(repositoryName: name, description: description, imageURL: imageURL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel.repository = viewModel.repositories.value[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RepoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchData()
    }
}

