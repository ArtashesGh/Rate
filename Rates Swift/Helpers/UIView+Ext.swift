//
//  UIView+Ext.swift
//  Rates Swift
//
//  Created by Artashes Noknok on 7/16/21.
//

import UIKit

//MARK: - Loader view
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let spinner = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
let loadingView = spinner.view
public extension UIView {
    func showLoader() {
        let currentWindow: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        currentWindow?.addSubview(loadingView!)
    }

    func removeLoader() {
        loadingView!.removeFromSuperview()
    }

    func animate(show: Bool, duration: TimeInterval, completion: @escaping ((Bool) -> Void) = {_ in }) {
        if show {
            alpha = 0.0
            isHidden = false
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1.0
            }, completion: { (finished) in
                completion(finished)
            })
            return
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: { (finished) in
            self.isHidden = true
            completion(finished)
        })
    }
}

