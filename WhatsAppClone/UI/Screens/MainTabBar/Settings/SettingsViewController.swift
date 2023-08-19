//
//  SettingsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 16/08/23.
//

import UIKit

public protocol SettingsViewController where Self: UIViewController {
    
}

class SettingsViewControllerImpl: UIViewController, SettingsViewController {
    
    private lazy var logoutButtonItem: UIBarButtonItem = {
      let item = UIBarButtonItem(
            title: "Deslogar",
            style: .plain,
            target: self,
            action: #selector(logoutButtonTapped)
        )
        item.tintColor = .systemRed
        return item
    }()
    
    private let headerView = HeaderInfoView()
    
    private lazy var selectButton: TextButton = {
        let view = TextButton(title: "Escolher imagem")
        view.changeTextColor(color: .systemBlue)
        return view
    }()
    
    public var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Ajustes"
        self.parent?.navigationItem.rightBarButtonItem = self.logoutButtonItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
    }
    
    private func configure() {
        self.selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    @objc private func selectButtonTapped() {
        self.presenter.selectButtonAction()
    }
    
    @objc private func logoutButtonTapped() {
        self.presenter.logoutButtonAction()
    }
}

// MARK: - ViewCode
extension SettingsViewControllerImpl: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([headerView, selectButton])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        // selectButton
        NSLayoutConstraint.activate([
            self.selectButton.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 10),
            self.selectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.selectButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func setupAdditionalConfiguration() {
        //self.headerView.delegate = self
    }
}

// MARK: - HeaderInfoViewDelegate
extension SettingsViewControllerImpl: HeaderInfoViewDelegate {
    
    func didSelectButtonTapped() {
        self.presenter.selectButtonAction()
    }
}
