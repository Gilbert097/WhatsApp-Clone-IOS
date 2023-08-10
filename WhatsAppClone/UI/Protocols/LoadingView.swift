//
//  LoadingView.swift
//  WhatsAppClone
//
//  Created by Gilberto Silva on 10/08/23.
//

import Foundation

public struct LoadingViewModel {
    public let isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}
