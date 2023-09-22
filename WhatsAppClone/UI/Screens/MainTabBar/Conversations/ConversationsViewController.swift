//
//  ConversationsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation
import UIKit

class ConversationsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
        view.separatorStyle = .none
        return view
    }()
    
    private var list: [ConversationViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        list.append(.init(name: "Gilberto Silva", lastMessage: "Olá"))
        list.append(.init(name: "Marina Silva", lastMessage: "Onde você está?"))
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Conversas"
    }
}

// MARK: - ViewCode
extension ConversationsViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([tableView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: - UITableViewDelegate
extension ConversationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }
}

//MARK: - UITableViewDataSource
extension ConversationsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.list[indexPath.row]
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath)
        if let conversationCell = tableViewCell as? ConversationCell {
            conversationCell.nameLabel.text = viewModel.name
            conversationCell.lastMessageLabel.text = viewModel.lastMessage
        }
        return tableViewCell
    }
}

public struct ConversationViewModel {
    public let name: String
    public let lastMessage: String
}
