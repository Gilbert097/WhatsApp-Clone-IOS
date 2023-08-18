//
//  HeaderInfoView.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 18/08/23.
//

import UIKit

public class HeaderInfoView: UIView {
    
    private let mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 5
        view.backgroundColor = .red
        return view
    }()
    
    public init() {
         super.init(frame: .zero)
         setupView()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
}

// MARK: - ViewCode
extension HeaderInfoView: ViewCode {
    
    func setupViewHierarchy() {
        self.addSubviews([mainStack])
    }
    
    func setupConstraints() {
        // mainStack
        NSLayoutConstraint.activate([
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            //self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            self.mainStack.heightAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
