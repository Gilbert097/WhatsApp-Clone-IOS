//
//  ConversationsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation
import UIKit

public protocol ConversationsView {
    func loadList()
}

public class ConversationsViewController: UIViewController, ConversationsView {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.identifier)
        view.separatorStyle = .none
        return view
    }()
    
    public var presenter: ConversationsPresenter!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.reloadData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Conversas"
        self.presenter.start()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.presenter.stop()
    }
    
    public func loadList() {
        self.tableView.reloadData()
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
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }
}

//MARK: - UITableViewDataSource
extension ConversationsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.conversations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.presenter.conversations[indexPath.row]
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.identifier, for: indexPath)
        if let conversationCell = tableViewCell as? ConversationCell {
            conversationCell.profileImageView.sd_setImage(with: viewModel.userUrlImage)
            conversationCell.nameLabel.text = viewModel.name
            conversationCell.lastMessageLabel.text = viewModel.lastMessage
        }
        return tableViewCell
    }
}
