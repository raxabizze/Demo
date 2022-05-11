//
//  Extensions.swift
//  Demo
//
//  Created by raxabizze on 2022/5/11.
//

import UIKit

extension UIView {
    class func initFromNib() -> Self {
        return initFromNib(self)
    }
    
    private class func initFromNib<T: UIView>(_ type: T.Type) -> T {
        let objects = Bundle.main.loadNibNamed(String(describing: self), owner: self, options: [:])
        return objects?.first as? T ?? T()
    }
    
    public class func loadFromNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { self.reloadData() })
        { _ in completion() }
    }
}
