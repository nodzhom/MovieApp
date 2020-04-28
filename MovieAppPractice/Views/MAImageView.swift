//
//  MAImageView.swift
//  MovieAppPractice
//
//  Created by Onur Com on 20.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MAImageView: UIImageView {
    
    let cache            = NetworkManager.shared.cache
    let placeholderImage = UIImage(systemName: "film")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        contentMode = .scaleAspectFill
        clipsToBounds       = true
        layer.cornerRadius = 10
        image = placeholderImage!
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self]image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
