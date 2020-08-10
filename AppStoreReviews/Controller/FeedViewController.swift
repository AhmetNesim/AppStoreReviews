//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController, ViewControllerDelegate {
    
    private let viewModel = ReviewViewModel()
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "cellId")
        tableView.rowHeight = 160
        
        viewModel.delegate = self
        
        showActivityIndicator()
        
        viewModel.getMostRecentReviews(language: .Dutch) { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.hideActivityIndicator()
            }
        }
        
        let items = ["1⭐️", "2⭐️", "3⭐️", "4⭐️", "5⭐️", "ALL"]

//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(reloadTableView))
//        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 45))
        let control = UISegmentedControl(items: items)
        control.translatesAutoresizingMaskIntoConstraints = false
        header.addSubview(control)
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[control]|", options: [], metrics: nil, views: ["control": control]))
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[control]|", options: [], metrics: nil, views: ["control": control]))
        tableView.tableHeaderView = header
    }
    
    @objc func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ReviewCell
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        c.viewModel = cellViewModel
        
        return c
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        let vc = DetailsViewController(viewModel: cellViewModel)
        navigationController!.pushViewController(vc, animated: true)
    }
    
}

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
