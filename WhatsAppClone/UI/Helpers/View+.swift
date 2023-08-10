//
//  View+.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import Foundation
import UIKit

extension UIView {
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
