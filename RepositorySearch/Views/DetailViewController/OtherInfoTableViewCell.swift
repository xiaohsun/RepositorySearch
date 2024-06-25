//
//  OtherInfoTableViewCell.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit

class OtherInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(OtherInfoTableViewCell.self)"
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Hi"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    private func setupUI() {
        contentView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
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

extension OtherInfoTableViewCell {
    func update(repositoryName: String, description: String?, imageURL: String) {
        // repositoryNamelabel.text = repositoryName
    }
}
