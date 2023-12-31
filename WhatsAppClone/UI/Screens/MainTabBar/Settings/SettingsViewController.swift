//
//  SettingsViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 16/08/23.
//

import UIKit

public protocol SettingsView: LoadingView, AlertView  where Self: UIViewController {
    func showImage(data: Data)
    func display(viewModel: SettingsViewModel)
}

class SettingsViewController: UIViewController {
    
    private var TAG: String { String(describing: SettingsViewController.self) }
    
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
    private let loadingView = ScreenLoadingView()
    
    public var presenter: SettingsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.parent?.title = "Ajustes"
        self.presenter.start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.parent?.navigationItem.rightBarButtonItem = self.logoutButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.parent?.navigationItem.rightBarButtonItem = nil
    }
    
    public func showImage(data: Data) {
        guard let image = UIImage(data: data) else { return }
        self.headerView.setImage(image: image)
    }
    
    public func display(viewModel: SettingsViewModel) {
        self.headerView.display(name: viewModel.name, email: viewModel.email, urlImage: viewModel.urlImage)
    }
  
    @objc private func logoutButtonTapped() {
        self.presenter.logoutButtonAction()
    }
}

// MARK: - ViewCode
extension SettingsViewController: ViewCode {
    
    func setupViewHierarchy() {
        self.view.addSubviews([headerView, loadingView])
    }
    
    func setupConstraints() {
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
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
        self.headerView.delegate = self
    }
}

// MARK: - HeaderInfoViewDelegate
extension SettingsViewController: HeaderInfoViewDelegate {
    
    func didSelectButtonTapped() {
        self.presenter.selectButtonAction()
    }
}

// MARK: - SettingsViewController
extension SettingsViewController: SettingsView {
    
    public func display(viewModel: LoadingViewModel) {
        self.loadingView.isHidden = !viewModel.isLoading
        self.loadingView.display(viewModel: viewModel)
    }
    
    public func showMessage(viewModel: AlertViewModel) {
        let alert = AlertFactory.build(viewModel: viewModel)
        present(alert, animated: true)
    }
}
