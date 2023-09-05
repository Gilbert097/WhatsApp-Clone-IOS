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
        //view.separatorStyle = .none
        return view
    }()
    
    
    private let bottomBar = BottomBarInputMessageView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 40
    }
}

//MARK: - UITableViewDataSource
extension ConversationViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        tableViewCell.backgroundColor = .clear
        return tableViewCell
    }
}
