//
//  ConversationViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import UIKit

public class ConversationViewController: UIViewController {
    
    private let bottomBar = BottomBarInputMessageView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - ViewCode
extension ConversationViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubview(bottomBar)
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        // bottomBar
        NSLayoutConstraint.activate([
            self.bottomBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.bottomBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.bottomBar.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Conversa"
        self.view.backgroundColor = .white
    }
}
