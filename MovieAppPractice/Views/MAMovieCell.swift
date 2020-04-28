//
//  MAMovieCell.swift
//  MovieAppPractice
//
//  Created by Onur Com on 18.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MAMovieCell: UICollectionViewCell {
    
    static let reuseID = "MovieCell"
    
    let cardView = UIView()
    let moviePosterView = MAImageView(frame: .zero)
    let movieNameLabel = MATitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        
        
        addSubview(cardView)
        cardView.addSubview(moviePosterView)
        cardView.addSubview(movieNameLabel)
        
        cardView.backgroundColor = .secondarySystemBackground
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.masksToBounds = false
    

        
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        moviePosterView.layer.masksToBounds = true
        moviePosterView.layer.cornerRadius = 10
        
        movieNameLabel.textAlignment = .center
        movieNameLabel.adjustsFontSizeToFitWidth = true
        //movieNameLabel.backgroundColor = .white
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            //cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            //cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cardView.heightAnchor.constraint(equalToConstant: 290),
            cardView.widthAnchor.constraint(equalToConstant: 150),
            
            moviePosterView.topAnchor.constraint(equalTo: cardView.topAnchor),
            moviePosterView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            moviePosterView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            moviePosterView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -45),
            
            movieNameLabel.topAnchor.constraint(equalTo: moviePosterView.bottomAnchor, constant: 2),
            movieNameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 4),
            movieNameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -4),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
