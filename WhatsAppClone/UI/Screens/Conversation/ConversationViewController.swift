//
//  ConversationViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import UIKit

public class ConversationViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - ViewCode
extension ConversationViewController: ViewCode {
    
    func setupViewHierarchy() {
    }
    
    func setupConstraints() {
    }
    
    func setupAdditionalConfiguration() {
        self.title = "Conversa"
        self.view.backgroundColor = .white
    }
}
