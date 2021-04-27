//
//  GifDetailsInteractor.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol GifDetailsInteractorProtocol: InteractorProtocol {
    func fetchGifDetails()
}

// MARK: - Implementation

final class GifDetailsInteractor: BaseInteractor {
    
    // MARK: - Properties
    
    private let presenter: GifDetailsPresenter
    private var context: GifDetailsContext?
    
    // MARK: - Initializers
    
    init(presenter: GifDetailsPresenter, context: GifDetailsContext? = nil) {
        self.presenter = presenter
        self.context = context
    }
}

// MARK: - GifDetailsInteractorProtocol

extension GifDetailsInteractor: GifDetailsInteractorProtocol {
    
    func fetchGifDetails() {
        guard let context = context else { return }
        presenter.presentGifDetails(context.model)
    }
}
