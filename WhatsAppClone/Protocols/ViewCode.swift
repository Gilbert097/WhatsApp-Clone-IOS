//
//  ViewCode.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import Foundation

protocol ViewCode {
    func setupViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension ViewCode {
    func setupView(){
        setupViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() { }
}
