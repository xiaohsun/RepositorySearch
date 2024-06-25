//
//  OtherInfoTableViewCell.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit

enum InfoCellProperty: CaseIterable {
    case watchers
    case forks
    case openIssues
    
    func displayString(for repo: Item) -> String {
        switch self {
        case .watchers:
            return "\(repo.watchers ?? 0) watchers"
        case .forks:
            return "\(repo.forks ?? 0) forks"
        case .openIssues:
            return "\(repo.openIssues ?? 0) open issues"
        }
    }
    
    static var allCases: [InfoCellProperty] {
        return [.watchers, .forks, .openIssues]
    }
}

class OtherInfoTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(OtherInfoTableViewCell.self)"
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "0 watchers"
        
        return label
    }()
    
    private func setupUI() {
        contentView.addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
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

extension OtherInfoTableViewCell {
    func update(info: String) {
        infoLabel.text = info
    }
}
