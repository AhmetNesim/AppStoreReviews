//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    private let viewModel: ReviewCellViewModel?
    
    private var titleLabel = UILabel()
    private var authorLabel = UILabel()
    private var contentLabel = UILabel()
    private var ratingVersionLabel = UILabel()
    
    init(viewModel: ReviewCellViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupViews()
    }
    
    func setupViews() {
        guard let viewModel = viewModel else { return }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(ratingVersionLabel)
        view.addSubview(authorLabel)
        view.addSubview(titleLabel)
        view.addSubview(contentLabel)
        
        ratingVersionLabel.text = viewModel.ratingVersionText
        ratingVersionLabel.font = UIFont.italicSystemFont(ofSize: 18)
        
        authorLabel.text = viewModel.author
        authorLabel.font = UIFont.systemFont(ofSize: 18)
        
        titleLabel.text = viewModel.title
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        contentLabel.text = viewModel.content
        contentLabel.numberOfLines = 0
        
        ratingVersionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        ratingVersionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        ratingVersionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        ratingVersionLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        authorLabel.topAnchor.constraint(equalTo: ratingVersionLabel.bottomAnchor, constant: 8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 72).isActive = true
        
        contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        contentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
    }
}
