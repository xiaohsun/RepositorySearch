//
//  LanguageStarTableViewCell.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit

class LanguageStarTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(LanguageStarTableViewCell.self)"
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Written in Unknown"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    lazy var starLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "0 stars"
        
        return label
    }()
    
    private func setupUI() {
        contentView.addSubview(languageLabel)
        contentView.addSubview(starLabel)
        
        NSLayoutConstraint.activate([
            languageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            languageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            languageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            starLabel.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor),
            starLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
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

extension LanguageStarTableViewCell {
    func update(language: String, star: Int) {
        languageLabel.text = "Written in \(language)"
        starLabel.text = "\(star) stars"
    }
}
