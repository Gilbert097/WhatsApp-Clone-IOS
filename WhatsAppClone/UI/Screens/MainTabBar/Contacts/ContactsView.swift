//
//  ContactsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import UIKit

public protocol ContactsView where Self: UIViewController {

}

class ContactsViewController: UIViewController, ContactsView {
    
    private var TAG: String { String(describing: ContactsViewController.self) }
    
    private lazy var addButtonItem: UIBarButtonItem = {
      let item = UIBarButtonItem(
            title: nil,
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        item.image = .add
        return item
    }()
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ContactTableViewCell.self, forCellReuseIdentifier: ContactTableViewCell.identifier)
        view.separatorStyle = .none
        return view
    }()
    
    private let loadingView = ScreenLoadingView()
    
    public var presenter: ContactsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Contatos"
        //self.presenter.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.parent?.navigationItem.rightBarButtonItem = self.addButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func addButtonTapped() {
        self.presenter.addButtonAction()
    }
}

//MARK: - ViewCode
extension ContactsViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([searchBar, tableView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        // searchBar
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
        // tableView
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.view.backgroundColor = .white
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

//MARK: - UITableViewDelegate
extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
}

//MARK: - UITableViewDataSource
extension ContactsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath)
        guard let contactsCell = tableViewCell as? ContactTableViewCell else { return UITableViewCell() }
        let index = indexPath.row + 1
        contactsCell.nameLabel.text = "Gilberto Silva \(index)"
        contactsCell.emailLabel.text = "gilberto.silva\(index)@gmail.com"
        return contactsCell
    }
}
