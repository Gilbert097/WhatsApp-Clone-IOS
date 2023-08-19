//
//  HeaderInfoView.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 18/08/23.
//

import UIKit

public protocol HeaderInfoViewDelegate: NSObject {
    func didSelectButtonTapped()
}

public class HeaderInfoView: UIView {
    
    private let mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "imagem-perfil"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 60
        view.clipsToBounds = true
        return view
    }()
    
    private let linesTextView = LinesTextView()
    
    private lazy var selectButton: TextButton = {
        let view = TextButton(title: "Escolher imagem")
        view.changeTextColor(color: .systemBlue)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    public weak var delegate: HeaderInfoViewDelegate?
    
    public init() {
        super.init(frame: .zero)
        setupView()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(image: UIImage) {
        imageView.image = image
    }
    
    private func configure() {
        self.selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    @objc private func selectButtonTapped() {
        self.delegate?.didSelectButtonTapped()
    }
    
}

// MARK: - ViewCode
extension HeaderInfoView: ViewCode {
    
    func setupViewHierarchy() {
        mainStack.addArrangedSubview(imageView)
        mainStack.addArrangedSubview(linesTextView)
        self.addSubviews([mainStack, selectButton])
    }
    
    func setupConstraints() {
        // mainStack
        NSLayoutConstraint.activate([
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
        ])
        
        // imageView
        NSLayoutConstraint.activate([
            self.imageView.heightAnchor.constraint(equalToConstant: 120),
            self.imageView.widthAnchor.constraint(equalToConstant: 120)
        ])
    
        
        // selectButton
        NSLayoutConstraint.activate([
            self.selectButton.topAnchor.constraint(equalTo: self.mainStack.bottomAnchor, constant: 10),
            self.selectButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.selectButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.selectButton.heightAnchor.constraint(equalToConstant: 30),
            //self.selectButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
    }
    
}
