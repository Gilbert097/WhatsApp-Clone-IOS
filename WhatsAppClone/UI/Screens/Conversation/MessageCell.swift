//
//  MessageCell.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 22/09/23.
//

import Foundation
import UIKit

public protocol TextMessageCell where Self: UITableViewCell {
    func setMessage(message: String)
}

public protocol ImageMessageCell where Self: UITableViewCell {
    func setImage(urlImage: URL)
}
