//
//  RightMessageTableViewCell.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 11/09/23.
//

import UIKit

class RightMessageTableViewCell: UITableViewCell {
    
    public static let identifier = "rightMessageCell"

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = Color.greenish_yellow
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let messageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 17)
        view.numberOfLines = 0
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// MARK: - ViewCode
extension RightMessageTableViewCell: ViewCode {
    
    func setupViewHierarchy() {
        self.containerView.addSubviews([messageLabel])
        self.contentView.addSubviews([containerView])
    }
    
    func setupConstraints() {
        
        //containerView
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 60),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
        
        //messageLabel
        NSLayoutConstraint.activate([
            self.messageLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
            self.messageLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10),
            self.messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    }
}
