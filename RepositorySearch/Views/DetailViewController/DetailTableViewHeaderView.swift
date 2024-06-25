//
//  DetailHeaderView.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit

class DetailTableViewHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "\(DetailTableViewHeaderView.self)"
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    func setupUI() {
        contentView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor)
        ])
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension DetailTableViewHeaderView {
    func update(imageURL: String) {
        iconImageView.kf.setImage(with: URL(string: imageURL))
    }
}
