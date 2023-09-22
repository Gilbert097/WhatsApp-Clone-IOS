//
//  LeftImageMessageCell.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 21/09/23.
//

import UIKit

class LeftImageMessageCell: UITableViewCell {
    
    public static let identifier = "leftImageMessageCell"

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let imageMessageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
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
extension LeftImageMessageCell: ViewCode {
    
    func setupViewHierarchy() {
        self.containerView.addSubviews([imageMessageView])
        self.contentView.addSubviews([containerView])
    }
    
    func setupConstraints() {
        
        //containerView
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -60),
            self.containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            self.containerView.heightAnchor.constraint(equalToConstant: 198)
        ])
        
        //messageLabel
        NSLayoutConstraint.activate([
            self.imageMessageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10),
            self.imageMessageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 10),
            self.imageMessageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -10),
            self.imageMessageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    }
}

// MARK: - ImageMessageCell
extension LeftImageMessageCell: ImageMessageCell {
    func setImage(urlImage: URL) {
        self.imageMessageView.sd_setImage(with: urlImage)
    }
}
