//
//  LinesTextView.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 18/08/23.
//

import UIKit

class LinesTextView : UIView {
    
    private let mainStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillProportionally
        view.spacing = 5
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.text = "Gilberto Silva"
        return view
    }()
    
    private let emailLabel: UILabel = {
        let view = UILabel()
        view.text = "gilberto.silva@gmail.com"
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ViewCode
extension LinesTextView: ViewCode {
    
    func setupViewHierarchy() {
        self.mainStack.addArrangedSubviews([nameLabel, emailLabel])
        self.addSubview(self.mainStack)
    }
    
    func setupConstraints() {
        // mainStack
        NSLayoutConstraint.activate([
            self.mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

