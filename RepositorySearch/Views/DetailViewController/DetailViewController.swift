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
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var repositoryNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Hi"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    lazy var writtenInlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hi"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    lazy var descriptionlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = "Hi"
        label.font = .systemFont(ofSize: 14)
        
        return label
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
//        viewModel.repository.sink { repo in
//            
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryNameTableViewCell.reuseIdentifier, for: indexPath) as? RepositoryNameTableViewCell, let repo = viewModel.repository 
            else { return UITableViewCell() }
            
            cell.update(repositoryName: repo.name)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageStarTableViewCell.reuseIdentifier, for: indexPath) as? LanguageStarTableViewCell, let repo = viewModel.repository
            else { return UITableViewCell() }
            
            // cell.update(language:star: <#T##Int#>)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherInfoTableViewCell.reuseIdentifier, for: indexPath) as? OtherInfoTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableViewHeaderView.reuseIdentifier) as? DetailTableViewHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        
        return header
    }
}
