//
//  HomeViewController.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var homeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()

    override func loadView() {
        super.loadView()
        self.view = self.homeView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
