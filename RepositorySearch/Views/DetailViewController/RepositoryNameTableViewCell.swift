//
//  RepositoryNameTableViewCell.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit

class RepositoryNameTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(RepositoryNameTableViewCell.self)"
    
    lazy var repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Hi"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private func setupUI() {
        contentView.addSubview(repositoryNameLabel)
        
        NSLayoutConstraint.activate([
            repositoryNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            repositoryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            repositoryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RepositoryNameTableViewCell {
    func update(repositoryName: String) {
        repositoryNameLabel.text = repositoryName
    }
}
