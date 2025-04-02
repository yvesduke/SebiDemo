//
//  UIView+Extensions.swift
//  DrSebi
//
//  Created by Yves Dukuze on 18/10/2023.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
