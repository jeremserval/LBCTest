//
//  LBCHomeItemTableViewCell.swift
//  LBCTest
//
//  Created by Jeremie Serval on 02/03/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCHomeItemTableViewCell: UITableViewCell {
    
    private var pictureView: UIImageView!
    private var titleLabel: UILabel!
    private var priceLabel: UILabel!
    private var categoryLabel: UILabel!
    private var urgentIndicator: UIView!
    private var containerView: UIView!
    
    private var item: LBCItem?
    
    override func prepareForReuse() {
        pictureView.image = nil
        titleLabel.text = ""
        priceLabel.text = ""
        categoryLabel.text = ""
        urgentIndicator.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    fileprivate func initUrgentIndicator(_ item: LBCItem) {
        // MARK: Init UrgentIndicator
        urgentIndicator = UIView()
        urgentIndicator.translatesAutoresizingMaskIntoConstraints = false
        urgentIndicator.isHidden = !item.is_urgent
        urgentIndicator.backgroundColor = .red
        addSubview(urgentIndicator)
        urgentIndicator.widthAnchor.constraint(equalToConstant: 8).isActive = true
        urgentIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        urgentIndicator.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        urgentIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        urgentIndicator.layoutIfNeeded()
    }
    
    func updateWithItem(item: LBCItem, category: LBCCategory) {
        self.item = item
        if item.images_url.count > 0 {
            initPictureView()
        }

        initUrgentIndicator(item)
        
        // MARK: Init TitleLabel
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = item.title
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "Raleway-Bold", size: 16)
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: urgentIndicator.leadingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 42).isActive = true
        titleLabel.layoutIfNeeded()

        // MARK: Init Category/Price labels
        categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.text = category.name
        categoryLabel.font = UIFont(name: "Raleway-Regular", size: 12)
        addSubview(categoryLabel)

        priceLabel = UILabel()
        priceLabel.text = item.priceString()
        priceLabel.textColor = .LBCColor
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont(name: "Raleway-Regular", size: 12)
        addSubview(priceLabel)
        
        priceLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 8).isActive = true
        priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: urgentIndicator.leadingAnchor, constant: -8).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -8).isActive = true
        priceLabel.layoutIfNeeded()

        categoryLabel.leadingAnchor.constraint(equalTo: pictureView.trailingAnchor, constant: 8).isActive = true
        categoryLabel.trailingAnchor.constraint(lessThanOrEqualTo: urgentIndicator.leadingAnchor, constant: -8).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
        categoryLabel.layoutIfNeeded()
        
    }
    
    fileprivate func initPictureView() {
        pictureView = UIImageView()
        pictureView.contentMode = .scaleAspectFill
        pictureView.translatesAutoresizingMaskIntoConstraints = false
        pictureView.load(from: URL(string: item?.images_url["small"] ?? "")!)
        pictureView.clipsToBounds = true
        addSubview(pictureView)
        pictureView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        pictureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        pictureView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        pictureView.widthAnchor.constraint(equalToConstant: 96).isActive = true
        pictureView.layoutIfNeeded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
