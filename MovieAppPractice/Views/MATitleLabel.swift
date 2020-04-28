//
//  MATitleLabel.swift
//  MovieAppPractice
//
//  Created by Onur Com on 21.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

class MATitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor                   = .label
        font = UIFont(name: "Helvetica-Light", size: 15)
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }

}
