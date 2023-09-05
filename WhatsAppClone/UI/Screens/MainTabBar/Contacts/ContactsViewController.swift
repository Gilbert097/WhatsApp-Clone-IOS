//
//  ContactsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import UIKit

public protocol ContactsView: LoadingView, AlertView where Self: UIViewController {
    func loadList()
}

class ContactsViewController: UIViewController {
    
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
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
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
        self.presenter.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.parent?.navigationItem.rightBarButtonItem = self.addButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
        self.presenter.stop()
    }
    
    @objc private func addButtonTapped() {
        self.presenter.addButtonAction()
    }
}

//MARK: - ViewCode
extension ContactsViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([searchBar, tableView, loadingView])
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
        
        // loadingView
        NSLayoutConstraint.activate([
            self.loadingView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.loadingView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
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
        return self.presenter.contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath)
        guard let contactsCell = tableViewCell as? ContactTableViewCell else { return UITableViewCell() }
        let currentItem = self.presenter.contactList[indexPath.row]
        contactsCell.nameLabel.text = currentItem.name
        contactsCell.emailLabel.text = currentItem.email
        contactsCell.loadProfileImage(url: currentItem.urlImage)
        return contactsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter.didSelectContact(index: indexPath.row)
    }
}

// MARK: - ContactsView
extension ContactsViewController: ContactsView {
    public func loadList() {
        self.tableView.reloadData()
    }
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = AlertFactory.build(viewModel: viewModel)
        present(alert, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ContactsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.presenter.searchTheList(text: searchBar.text ?? .init())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.presenter.clearSearch()
        }
    }
}
