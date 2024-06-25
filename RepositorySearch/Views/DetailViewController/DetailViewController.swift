//
//  DetailViewController.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    let viewModel = DetailViewModel()
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.register(DetailTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: DetailTableViewHeaderView.reuseIdentifier)
        tableView.register(RepositoryNameTableViewCell.self, forCellReuseIdentifier: RepositoryNameTableViewCell.reuseIdentifier)
        tableView.register(LanguageStarTableViewCell.self, forCellReuseIdentifier: LanguageStarTableViewCell.reuseIdentifier)
        tableView.register(OtherInfoTableViewCell.self, forCellReuseIdentifier: OtherInfoTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    func reloadData() {
        detailTableView.reloadData()
    }
    
    private func setupUI() {
        view.addSubview(detailTableView)
        NSLayoutConstraint.activate([
            detailTableView.topAnchor.constraint(equalTo: view.topAnchor),
            detailTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = viewModel.repository?.owner.login
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2 + InfoCellProperty.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryNameTableViewCell.reuseIdentifier, for: indexPath) as? RepositoryNameTableViewCell, let repo = viewModel.repository
            else { return UITableViewCell() }
            
            cell.update(repositoryName: repo.fullName)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageStarTableViewCell.reuseIdentifier, for: indexPath) as? LanguageStarTableViewCell,
                  let repo = viewModel.repository
            else { return UITableViewCell() }
            
            if let language = repo.language, let star = repo.stargazersCount {
                cell.update(language: language, star: star)
            }
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherInfoTableViewCell.reuseIdentifier, for: indexPath) as? OtherInfoTableViewCell,
                  let repo = viewModel.repository
            else { return UITableViewCell() }
            
            let infoType = InfoCellProperty.allCases[indexPath.row - 2]
            cell.update(info: infoType.displayString(for: repo))
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableViewHeaderView.reuseIdentifier) as? DetailTableViewHeaderView,
              let repo = viewModel.repository
        else { return UITableViewHeaderFooterView() }
        
        header.update(imageURL: repo.owner.avatarURL ?? "")
        
        return header
    }
}
