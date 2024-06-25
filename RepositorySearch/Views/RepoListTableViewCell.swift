//
//  RepoListTableViewCell.swift
//  RepositorySearch
//
//  Created by 徐柏勳 on 6/25/24.
//

import UIKit
import Kingfisher

class RepoListTableViewCell: UITableViewCell {
    static let reuseIdentifier = "\(RepoListTableViewCell.self)"
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var repositoryNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(containerView)
        containerView.addSubview(repositoryNamelabel)
        containerView.addSubview(descriptionlabel)
        
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 100),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            containerView.topAnchor.constraint(equalTo: repositoryNamelabel.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: descriptionlabel.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            repositoryNamelabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            repositoryNamelabel.bottomAnchor.constraint(equalTo: descriptionlabel.topAnchor, constant: -5),
            
            descriptionlabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            descriptionlabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            descriptionlabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
    }
}

extension RepoListTableViewCell {
    func update(repositoryName: String, description: String?, imageURL: String) {
        repositoryNamelabel.text = repositoryName
        descriptionlabel.text = description
        iconImageView.kf.setImage(with: URL(string: imageURL))
    }
}
