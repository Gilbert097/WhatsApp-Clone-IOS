//
//  BottomBarInputMessageView.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import Foundation
import UIKit

public protocol BottomBarInputMessageDelegate: NSObject {
    func sendButtonTapped()
}

class BottomBarInputMessageView: UIView {
    
    public var text: String {
        textField.text ?? .init()
    }
    
    private let attachmentButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(.init(named: "arquivo_icone"), for: .normal)
        view.setTitle(nil, for: .normal)
        return view
    }()
    
    private let textField = PrimaryTextField()
    
    private let sendButton: TextButton = {
        let view = TextButton(title: "Enviar", fontSize: 17)
        view.changeTextColor(color: .systemBlue)
        return view
    }()
    
    public weak var delegate: BottomBarInputMessageDelegate?
    
    public init() {
        super.init(frame: .zero)
        setupView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    }
    
    @objc private func sendButtonTapped() {
        self.delegate?.sendButtonTapped()
    }
}

// MARK: - ViewCode
extension BottomBarInputMessageView: ViewCode {
    func setupViewHierarchy() {
        self.addSubviews([attachmentButton, textField, sendButton])
    }
    
    func setupConstraints() {
        // Self
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // attachmentButton
        NSLayoutConstraint.activate([
            self.attachmentButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            self.attachmentButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.attachmentButton.heightAnchor.constraint(equalToConstant: 32),
            self.attachmentButton.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        // textField
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.attachmentButton.trailingAnchor, constant: 8),
            self.textField.trailingAnchor.constraint(equalTo: self.sendButton.leadingAnchor),
            self.textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.textField.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        // sendButton
        NSLayoutConstraint.activate([
            self.sendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            self.sendButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.sendButton.heightAnchor.constraint(equalToConstant: 30),
            //self.sendButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
    }
}
