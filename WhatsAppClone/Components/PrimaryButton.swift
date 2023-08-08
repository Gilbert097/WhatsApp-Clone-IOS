//
//  PrimaryButton.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 08/08/23.
//

import Foundation
import UIKit

public class PrimaryButton: UIButton {
    private let title: String
    private let fontSize: CGFloat
    private let weight: UIFont.Weight
    
    public init(title: String, fontSize: CGFloat = 16, weight: UIFont.Weight = .regular) {
        self.title = title
        self.fontSize = fontSize
        self.weight = weight
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentHorizontalAlignment = .center
        
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
            config.attributedTitle = AttributedString(self.title, attributes: container)
            config.baseBackgroundColor = Color.secondary
            config.baseForegroundColor = .white
            self.configuration = config
        }
    }
    
    public func update(text: String, color: UIColor) {
        var config = self.configuration
        config!.background.backgroundColor = color
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        config!.attributedTitle = AttributedString(text, attributes: container)
        self.configuration = config
    }
}
