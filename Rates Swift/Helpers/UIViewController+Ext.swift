//
//  UIViewController+Ext.swift
//  Rates Swift
//
//  Created by Artashes Noknok on 7/16/21.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
