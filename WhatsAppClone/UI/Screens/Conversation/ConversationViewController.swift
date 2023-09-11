//
//  ConversationViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 05/09/23.
//

import UIKit

public class ConversationViewController: UIViewController {
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundView =  UIImageView(image: .init(named: "bg"))
        view.register(LeftMessageTableViewCell.self, forCellReuseIdentifier: LeftMessageTableViewCell.identifier)
        view.register(RightMessageTableViewCell.self, forCellReuseIdentifier: RightMessageTableViewCell.identifier)
        view.separatorStyle = .none
        return view
    }()
    
    private let bottomBar = BottomBarInputMessageView()
    
    private let conversations = ["Olá, tudo bem?", "Tudo ótimo meu amigo", "Estou muito doente e precisava falar com você, será que podetia ir na farmácia pegar alguns remédios?"]

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.tableView.reloadData()
    }
}

// MARK: - ViewCode
extension ConversationViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([tableView, bottomBar])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomBar.topAnchor),
        ])
        
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: - UITableViewDelegate
extension ConversationViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension ConversationViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let message = self.conversations[index]
        let isRight = index % 2 == 0
        
        let identifier = isRight ? RightMessageTableViewCell.identifier : LeftMessageTableViewCell.identifier
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
       
        if isRight {
            let rightCell = tableViewCell as! RightMessageTableViewCell
            rightCell.messageLabel.text = message
        } else {
            let leftCell = tableViewCell as! LeftMessageTableViewCell
            leftCell.messageLabel.text = message
        }
        
        return tableViewCell
    }
}
