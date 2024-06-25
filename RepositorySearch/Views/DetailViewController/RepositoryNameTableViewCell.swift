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
        label.text = "Name"
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        label.textAlignment = .center
        
        return label
    }()
    
    private func setupUI() {
        contentView.addSubview(repositoryNameLabel)
        
        NSLayoutConstraint.activate([
            repositoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            repositoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            repositoryNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            repositoryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
