//
//  AddContactViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import UIKit

class AddContactViewController: UIViewController {
    
    let descriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Digite o e-mail para cadastar um novo contato:"
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    private let emailField: PrimaryTextField = {
        let view = PrimaryTextField()
        view.placeholder = "user@gmail.com"
        view.keyboardType = .emailAddress
        view.autocapitalizationType = .none
        return view
    }()
    
    private let addButton: TextButton = {
        let view = TextButton(title: "Adicionar", fontSize: 17)
        view.changeTextColor(color: .systemBlue)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - ViewCode
extension AddContactViewController: ViewCode {
    func setupViewHierarchy() {
        self.view.addSubviews([descriptionLabel, emailField, addButton])
    }
    
    func setupConstraints() {
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        //descriptionLabel
        NSLayoutConstraint.activate([
            self.descriptionLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            self.descriptionLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10)
        ])
        
        //emailField
        NSLayoutConstraint.activate([
            self.emailField.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 5),
            self.emailField.leadingAnchor.constraint(equalTo: self.descriptionLabel.leadingAnchor),
            self.emailField.trailingAnchor.constraint(equalTo: self.descriptionLabel.trailingAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // addButton
        NSLayoutConstraint.activate([
            self.addButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.addButton.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 8),
            self.addButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
    }
}
