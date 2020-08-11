//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

class FeedViewController: UITableViewController, FeedViewControllerDelegate {
    
    private let viewModel = FeedViewModel()
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "cellId")
        tableView.rowHeight = 160
        addSegmentControl()
        addNavigationItem()
        viewModel.delegate = self
        showActivityIndicator()
        viewModel.getReviews {
            self.hideActivityIndicator()
        }
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func routeToDetail(model: ReviewCellViewModel) {
        let vc = DetailsViewController(viewModel: model)
        navigationController!.pushViewController(vc, animated: true)
    }
    
}

extension FeedViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfReviews()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ReviewCell
        
        let cellViewModel = viewModel.cellViewModel(index: indexPath.row)
        c.viewModel = cellViewModel
        
        return c
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelect(index: indexPath.row)
    }
}

extension FeedViewController {
    
    func addSegmentControl() {
        let items = Rating.allCases.compactMap { $0.title }
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 45))
        let control = UISegmentedControl(items: items)
        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 5
        header.addSubview(control)
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[control]|", options: [], metrics: nil, views: ["control": control]))
        header.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[control]|", options: [], metrics: nil, views: ["control": control]))
        
        tableView.tableHeaderView = header
    }
    
    func addNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Top Three Words", style: .plain, target: self, action: #selector(showMostRecentWords))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        guard let selectedRating = Rating(rawValue: sender.selectedSegmentIndex + 1) else { return }
        viewModel.filter(rating: selectedRating)
    }
    
    @objc func showMostRecentWords () {
        let alert = UIAlertController(title: "Top Three Occurring Words", message: nil , preferredStyle: UIAlertController.Style.alert)
        for word in viewModel.getMostFrequentWords() {
            alert.addAction(UIAlertAction(title: word, style: UIAlertAction.Style.default, handler: nil))
        }
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
