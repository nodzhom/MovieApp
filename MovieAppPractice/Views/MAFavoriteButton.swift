//
//  MAFavoriteButton.swift
//  MovieAppPractice
//
//  Created by Onur Com on 22.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MAFavoriteButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setImage(UIImage(systemName: "heart"), for: .normal)
        contentMode = .scaleAspectFit        
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .label
        
    }
    
}
