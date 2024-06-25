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
            viewModel.repositories.send([])
            viewModel.fetchRepositories(query: text)
        }
    }
    
    @objc private func refreshToLoad(){
        if searchBar.text == "" {
            showAlert()
        } else {
            fetchData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.refresher.endRefreshing()
            }
        }
    }
    
    private func combineRepositories() {
        viewModel.repositories.sink { [weak self] _ in
            self?.repoListTableView.reloadData()
            self?.searchBar.resignFirstResponder()
        }.store(in: &cancellables)
    }
    
    private func setupUI() {
        view.addSubview(repoListTableView)
        repoListTableView.addSubview(refresher)
        repoListTableView.tableHeaderView = searchBar
        
        NSLayoutConstraint.activate([
            repoListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            repoListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            repoListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            repoListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    @objc private func showAlert() {
        let alert1 = UIAlertController(title: "Oops!", message: "The data couldn't be read because it is missing.", preferredStyle: .alert)
        
        alert1.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
            self?.refresher.endRefreshing()
            alert1.dismiss(animated: true)
        }))
        
        present(alert1, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        combineRepositories()
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
        cell.update(repositoryName: name, description: description, imageURL: imageURL ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        detailVC.viewModel.repository = viewModel.repositories.value[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension RepoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            viewModel.repositories.send([])
        }
    }
}

