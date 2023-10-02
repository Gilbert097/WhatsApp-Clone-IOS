//
//  String+.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 02/10/23.
//

import Foundation

extension String {
    public func toURL() -> URL? { URL(string: self) }
}
