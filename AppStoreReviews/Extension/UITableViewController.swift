//
//  UITableViewController.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 11.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

extension UITableViewController {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView()
            activityView.style = UIActivityIndicatorView.Style.large
            activityView.center = self.view.center
            activityView.hidesWhenStopped = true
            self.tableView.backgroundView = activityView
            
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
        }
    }
}

