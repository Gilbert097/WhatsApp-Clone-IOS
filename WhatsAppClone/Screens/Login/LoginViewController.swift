//
//  LoginViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension LoginViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([logoImageView])
    }
    
    func setupConstraints() {
        
        // logoImageView
        NSLayoutConstraint.activate([
            self.logoImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoImageView.heightAnchor.constraint(equalToConstant: 200),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 240)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = Color.primary
    }
}
