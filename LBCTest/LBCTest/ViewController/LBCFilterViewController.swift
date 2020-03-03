//
//  LBCFilterViewController.swift
//  LBCTest
//
//  Created by Jeremie Serval on 02/03/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCFilterViewController: LBCViewController {
    
    private var tableView: UITableView!
    private var categories: LBCCategories?
    private var validateButton: UIButton!
    private var selectedCategories: Array<Int> = []
    var validateCompletion: ((Array<Int>) -> Void)?
    private var bottomVBConstraint: NSLayoutConstraint?
    
    func update(with categories: LBCCategories?) {
        self.categories = categories
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        initValidateButton()
        initTableView()
    }
    
    @objc private func validateAction(sender: UIButton!) {
        
        if let completion = validateCompletion  {
            completion(selectedCategories)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func initValidateButton() {
        
        validateButton = UIButton(type: .system)
        
        validateButton.setTitle(NSLocalizedString("LBC.VALIDATE", comment: ""), for: .normal)
        validateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        validateButton.setTitleColor(.white, for: .normal)
        validateButton.backgroundColor = .LBCColor
        validateButton.translatesAutoresizingMaskIntoConstraints = false
        validateButton.addTarget(self, action: #selector(validateAction(sender:)), for: .touchUpInside)
        view.addSubview(validateButton)
        
        validateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4).isActive = true
        validateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4).isActive = true
        validateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4).isActive = true
        validateButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        validateButton.clipsToBounds = true
        validateButton.layer.cornerRadius = 8
        
        validateButton.layoutIfNeeded()
    }
    
    private func initTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LBCFilterTableViewCell.self, forCellReuseIdentifier: "categorie")
        tableView.isHidden = (categories?.items.count == 0)
        view.addSubview(tableView)
        
        tableView.bottomAnchor.constraint(equalTo: validateButton.topAnchor, constant: -4.0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4.0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4.0).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 4.0).isActive = true
        tableView.layoutIfNeeded()
    }
}

extension LBCFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "categorie", for: indexPath) as! LBCFilterTableViewCell
        
        cell.textLabel?.text = categories?.items[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath)  as? LBCFilterTableViewCell{
            cell.updateState()
            if let items = categories?.items {
                if cell.state {
                    selectedCategories.append(items[indexPath.row].id)
                } else {
                    selectedCategories.removeAll { (item) -> Bool in
                        return (item == items[indexPath.row].id)
                    }
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
