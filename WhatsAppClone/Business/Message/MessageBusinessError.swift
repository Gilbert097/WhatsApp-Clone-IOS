//
//  MessageBusinessError.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 25/09/23.
//

import Foundation

public enum SendMessageBusinessError: Error {
    case unexpected
    case updloadAttachment
    case senderUser
    case recipientUser
}
