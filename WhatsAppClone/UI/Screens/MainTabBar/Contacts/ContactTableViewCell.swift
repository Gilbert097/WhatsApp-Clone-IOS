//
//  ContactTableViewCell.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 23/08/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    public static let identifier = "contactsCell"
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.image = UIImage(named: "imagem-perfil")
        return view
    }()
    
    let nameLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 17)
        return view
    }()
    
    let emailLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .lightGray
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

//MARJK: - ViewCode
extension ContactTableViewCell: ViewCode {
    
    func setupViewHierarchy() {
        self.containerView.addSubviews([nameLabel, emailLabel])
        self.contentView.addSubviews([profileImageView, containerView])
    }
    
    func setupConstraints() {
        
        // profileImageView
        NSLayoutConstraint.activate([
            self.profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 50),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // containerView
        NSLayoutConstraint.activate([
            self.containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 10),
            self.containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.containerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
        
        // emailLabel
        NSLayoutConstraint.activate([
            self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.emailLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor)
        ])
    }
}
