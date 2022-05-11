//
//  ViewController.swift
//  Demo
//
//  Created by raxabizze on 2022/5/11.
//

import UIKit

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = String(describing: CustomCell.self)
    private let headerIdentifier = String(describing: CustomHeader.self)
    private var cellStates: [Bool] = []
    private var list: [[[String]]] = [[["111111111", "222222222", "33333333", "444444444", "5555555555"],
                                       ["111111", "2222", "333", "4", "55555555555"],
                                       ["11111", "2", "3333333333333", "44", "555555555"]],
                                      [["11111111", "222222", "33333333"],
                                       ["11111111", "22222222222", "3333333333"],
                                       ["11", "22", "33"]],
                                      [["33333333", "22222222", "1111111", "444444444"],
                                       ["1", "22", "33", "4444444"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.forEach { _ in cellStates.append(true)}
        
        tableView.register(CustomCell.loadFromNib(), forCellReuseIdentifier: cellIdentifier)
        tableView.register(CustomHeader.loadFromNib(), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! CustomHeader
        view.titleLabel.text = "Title"
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        cell.selectionStyle = .none
        cell.isExpanded = cellStates[indexPath.row]
        cell.list = list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellStates[indexPath.row] = !cellStates[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
