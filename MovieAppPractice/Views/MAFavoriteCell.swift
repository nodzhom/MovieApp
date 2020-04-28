//
//  MAFavoriteCell.swift
//  MovieAppPractice
//
//  Created by Onur Com on 22.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MAFavoriteCell: UITableViewCell {
    
    static let reuseID = "FavoriteCell"
    
    let posterView = MAImageView(frame: .zero)
    let titleLabel = MATitleLabel()
    let cardView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.textAlignment = .center
        posterView.contentMode = .center
        configureCardView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCardView() {
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
        
    }
    
    private func configure() {
        contentView.addSubview(cardView)
        cardView.addSubview(posterView)
        cardView.addSubview(titleLabel)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.heightAnchor.constraint(equalToConstant: 180),
            
            posterView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
