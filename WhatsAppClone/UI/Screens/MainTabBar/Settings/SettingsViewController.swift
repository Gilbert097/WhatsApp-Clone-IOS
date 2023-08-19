//
//  SettingsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 16/08/23.
//

import UIKit

public protocol SettingsViewController where Self: UIViewController {
    func showImage(data: Data)
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

    public var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
    
    public func showImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        self.headerView.setImage(image: image)
    }
  
    @objc private func logoutButtonTapped() {
        self.presenter.logoutButtonAction()
    }
}

// MARK: - ViewCode
extension SettingsViewControllerImpl: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([headerView])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.headerView.delegate = self
    }
}

// MARK: - HeaderInfoViewDelegate
extension SettingsViewControllerImpl: HeaderInfoViewDelegate {
    
    func didSelectButtonTapped() {
        self.presenter.selectButtonAction()
    }
}
