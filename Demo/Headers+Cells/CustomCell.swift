//
//  CustomCell.swift
//  Demo
//
//  Created by raxabizze on 2021/11/23.
//  Copyright © 2021 raxabizze. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private let cellIdentifier = String(describing: CustomContentCell.self)
    private let headerIdentifier = String(describing: CustomCellHeader.self)
    var isExpanded = true
    var list: [[String]] = []
    
    override func layoutSubviews() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomContentCell.loadFromNib(), forCellReuseIdentifier: cellIdentifier)
        tableView.register(CustomCellHeader.loadFromNib(), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
        if #available(iOS 15.0, *) { 
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.reloadData {
            self.tableViewHeight.constant = self.isExpanded ? self.tableView.contentSize.height : 0
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
   
        setNeedsLayout()
        layoutIfNeeded()
        
        let defaultHeight: CGFloat = 90
        return CGSize(width: 0, height: !isExpanded ? defaultHeight : tableView.contentSize.height + defaultHeight)
    }
}

extension CustomCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! CustomCellHeader
        view.backgroundColor = .clear
        view.titleLabel.text = "title"
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomContentCell
        cell.selectionStyle = .none
        cell.backgroundColor = .lightGray
        cell.titleLabel.text = list[indexPath.section][indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
