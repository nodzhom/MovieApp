//
//  UIViewController+Ext.swift
//  MovieAppPractice
//
//  Created by Onur Com on 27.04.2020.
//  Copyright © 2020 Onur Com. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentMAAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            alertVC.addAction(alertButton)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
