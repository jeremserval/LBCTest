//
//  LBCHomeContentView.swift
//  LBCTest
//
//  Created by Jeremie Serval on 27/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCHomeContentView: UIView {
    
    private var emptyView: LBCEmptyView = LBCEmptyView()
    private var tableView: UITableView!
    private var contentView: UIView!
    private var items: [LBCItem] = []
    private var categories: LBCCategories?
    private var refreshControl = UIRefreshControl()
    
    var detailCompletion: ((LBCItem) -> Void)?
    
    var refreshCompletion: (() -> Void)? {
        didSet {
            emptyView.refreshCompletion = self.refreshCompletion
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        
        showEmptyView()
        initTableView()
    }
    
    @objc func refresh(sender:AnyObject) {
        if let completion = refreshCompletion {
            completion()
        }
        refreshControl.endRefreshing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        showEmptyView()
        initTableView()
    }
    
    fileprivate func initTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        tableView.register(LBCHomeItemTableViewCell.self, forCellReuseIdentifier: "item")
        tableView.isHidden = (items.count == 0)
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        tableView.layoutIfNeeded()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)

    }
    
    fileprivate func showEmptyView() {
        emptyView = LBCEmptyView()
        emptyView.refreshCompletion = refreshCompletion
        addSubview(emptyView)
        
        emptyView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        emptyView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        emptyView.layoutIfNeeded()
    }
    
    func update(with items: [LBCItem], categories: LBCCategories) {

// Format list by date & urgent items on top

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        self.items = items.sorted(by: { (a, b) -> Bool in
            return dateFormatter.date(from: a.creation_date)!.compare(dateFormatter.date(from: b.creation_date)!) == .orderedDescending
        }).sorted(by: { (a, b) -> Bool in
            return a.is_urgent && !b.is_urgent
        })
        
        self.categories = categories

        DispatchQueue.main.async {
            if (items.count == 0) {
                self.tableView.isHidden = true
            } else {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
}

extension LBCHomeContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : LBCHomeItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "item", for: indexPath) as! LBCHomeItemTableViewCell
        
        cell.updateWithItem(item: items[indexPath.row], category: categories?.items.first(where: { (cat: LBCCategory) -> Bool in
            return cat.id == items[indexPath.row].category_id
        }) ?? LBCCategory(id: -1, name: "N/A"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let completion = detailCompletion else { return }
        
        completion(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}
