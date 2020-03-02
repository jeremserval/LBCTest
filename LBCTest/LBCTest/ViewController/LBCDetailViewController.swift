//
//  LBCDetailViewController.swift
//  LBCTest
//
//  Created by Jeremie Serval on 02/03/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCDetailViewController: LBCViewController {

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionTV: UITextView!
    private var categoryLabel: UILabel!
    private var priceLabel: UILabel!
    private var dateLabel: UILabel!
    private var urgentView: UIView!
    
    private var categories: LBCCategories?
    private var item: LBCItem?
    
    init(with item: LBCItem, categories: LBCCategories?) {
        self.item = item
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initImageView()
        initTitleLabel()
        initPriceLabel()
        initDateLabel()
        initCategoryLabel()
        initDescriptionLabel()
    }
    
    fileprivate func initCategoryLabel() {
        categoryLabel = UILabel()
        
        categoryLabel.text = categories?.items.first(where: { (category) -> Bool in
            return item?.category_id == category.id
            })?.name
        categoryLabel.textColor = .LBCColor
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont(name: "Raleway-Regular", size: 12)
        view.addSubview(categoryLabel)
        categoryLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        categoryLabel.layoutIfNeeded()
    }
    
    fileprivate func initDescriptionLabel() {
        descriptionTV = UITextView()
        descriptionTV.text = item?.description
        descriptionTV.translatesAutoresizingMaskIntoConstraints = false
        descriptionTV.font = UIFont(name: "Raleway-Regular", size: 16)
        descriptionTV.sizeToFit()
        descriptionTV.isEditable = false
        descriptionTV.isScrollEnabled = false
        view.addSubview(descriptionTV)
        descriptionTV.bottomAnchor.constraint(lessThanOrEqualTo: categoryLabel.topAnchor, constant: -4).isActive = true
        descriptionTV.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        descriptionTV.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        descriptionTV.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        descriptionTV.layoutIfNeeded()
        descriptionTV.isScrollEnabled = true
    }
    
    fileprivate func initDateLabel() {
        dateLabel = UILabel()
        dateLabel.text = item?.dateString()
        dateLabel.textColor = .gray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont(name: "Raleway-Regular", size: 16)
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        dateLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24).isActive = true
        dateLabel.layoutIfNeeded()

    }
    
    fileprivate func initPriceLabel() {
        priceLabel = UILabel()
        priceLabel.text = item?.priceString()
        priceLabel.textColor = .LBCColor
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont(name: "Raleway-Regular", size: 24)
        view.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        priceLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28).isActive = true

        priceLabel.layoutIfNeeded()
    }
    
    fileprivate func initTitleLabel() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = item?.title
        titleLabel.textColor = .LBCColor
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Raleway-Bold", size: 24)
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 28).isActive = true
        titleLabel.layoutIfNeeded()
    }
    
    fileprivate func initImageView() {
        
        imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.load(from: URL(string: item?.images_url["thumb"] ?? "")!)
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        imageView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.frame.width * 9/16).isActive = true
        imageView.layoutIfNeeded()
    }
}
