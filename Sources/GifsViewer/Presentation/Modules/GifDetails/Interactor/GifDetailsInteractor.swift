//
//  GifDetailsInteractor.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

protocol GifDetailsInteractor: Interactor {
    func fetchGifDetails()
}

final class GifDetailsInteractorImplementation: BaseInteractor {
    
    private let presenter: GifDetailsPresenter
    private let viewModel: GifItemViewModel?

    init(presenter: GifDetailsPresenter, viewModel: GifItemViewModel? = nil) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
}

extension GifDetailsInteractorImplementation: GifDetailsInteractor {
    
    func fetchGifDetails() {
        guard let viewModel = viewModel else { return }
        presenter.presentGifDetails(viewModel)
    }
}
