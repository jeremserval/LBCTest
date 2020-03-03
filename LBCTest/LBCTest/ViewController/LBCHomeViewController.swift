//
//  ViewController.swift
//  LBCTest
//
//  Created by Jeremie Serval on 26/02/2020.
//  Copyright © 2020 Jeremie Serval. All rights reserved.
//

import UIKit

class LBCHomeViewController: LBCViewController, MainViewProtocol {
    
    private var contentView: LBCHomeContentView!
    private var buttonTest: UIButton!
    private var filterView: UIButton!
    
    public var apiManager: LBCAPIManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initContentView()
        initFilterView()
    }
  
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.updateContentView([])
    }
    
    init(with api: LBCAPIManager) {
        self.apiManager = api
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func updateContentView(_ filters: [Int]) {
        
        guard let categories = apiManager?.categories else { return }
        
        apiManager?.fetchAds(forceRefresh: false) { [weak self] (list) in
            
            DispatchQueue.main.async {
                self?.filterView.setTitle("\(filters.count) \(filters.count > 1 ? NSLocalizedString("LBC.Filters", comment: ""): NSLocalizedString("LBC.Filter", comment: ""))", for: .normal)
            }
            
            if (filters.count == 0){ self?.contentView.update(with: list, categories: categories)}
            else {
                let filterList = list.filter { (item) -> Bool in
                    return filters.contains(item.category_id)
                }
              
                DispatchQueue.main.async {
                  self?.contentView.update(with: filterList, categories: categories)
                }
            }
        }
    }
    
    @objc private func filterAction() {
        
        let filterVC: LBCFilterViewController = LBCFilterViewController()
        filterVC.validateCompletion = { [weak self] items in
            
            DispatchQueue.main.async {
                self?.updateContentView(items)
            }
        }
        
        navigationController?.present(filterVC, animated: true, completion: nil)
        filterVC.update(with: apiManager?.categories)
    }
    
    private func initFilterView() {
        filterView = UIButton(type: .system)
        filterView.setTitle("0 \(NSLocalizedString("LBC.Filter", comment: ""))", for: .normal)
        filterView.setTitleColor(.white, for: .normal)
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.backgroundColor = .LBCColor
        filterView.addTarget(self, action: #selector(filterAction), for: .touchDown)
        view.addSubview(filterView)
        
        let bottom: NSLayoutConstraint = NSLayoutConstraint(item: filterView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -24)
        let trailing: NSLayoutConstraint = NSLayoutConstraint(item: filterView!, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: -24)
        let height: NSLayoutConstraint = .init(item: filterView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 60)
        let width: NSLayoutConstraint = .init(item: filterView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 60)
        filterView.clipsToBounds = true
        filterView.layer.cornerRadius = 30
        NSLayoutConstraint.activate([width,bottom, trailing, height])
        
    }
    
    func initContentView() {
        contentView = LBCHomeContentView()
        contentView.refreshCompletion = { [weak self] in
            self?.updateContentView([])
        }
        contentView.detailCompletion = { [weak self] item in
            DispatchQueue.main.async {
                self?.navigationController?.isNavigationBarHidden = false
                let detailVC: LBCDetailViewController = LBCDetailViewController(with: item, categories: self?.apiManager?.categories)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
        view.addSubview(contentView)
        
        let topConstraint = NSLayoutConstraint.init(item: contentView!, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let bottomConstraint =  NSLayoutConstraint.init(item: contentView!, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let widthContraint = NSLayoutConstraint(item: contentView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activate([bottomConstraint, topConstraint, widthContraint])
    }
    
    func initFooterView() {}
}

