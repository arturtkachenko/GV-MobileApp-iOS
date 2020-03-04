//
//  GifSearchInteractor.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

protocol GifSearchInteractor: Interactor {
    
    func openGifDetailsModule(_ viewModel: GifItemViewModel)
    func fetchGifs(by searchQuery: String)
    func startTimer()
    func endTimer()
}

final class GifSearchInteractorImplementation: BaseInteractor {
    
    private enum Constants {
        static let timeInterval: TimeInterval = 10
    }
    
    private let presenter: GifSearchPresenter
    private let gifBackendService: GifBackendService
    
    private var timer = Timer()

    init(presenter: GifSearchPresenter, gifBackendService: GifBackendService) {
        self.presenter = presenter
        self.gifBackendService = gifBackendService
    }
    
    // MARK: - Actions
    
    @objc private func fetchRandomGif() {
        gifBackendService.fetchQueue.async { [weak self] in
            guard let self = self else { return }
            
            self.gifBackendService.getRandomGif { randomGif in
                switch randomGif {
                case .success(let model):
                    DispatchQueue.main.async {
                        self.presenter.presentRandomGif(model)
                    }
                case .failure(let error):
                    print("Error occured: \(error)")
                }
            }
        }
    }
}

extension GifSearchInteractorImplementation: GifSearchInteractor {
    
    func startTimer() {
        fetchRandomGif()
        timer = Timer.scheduledTimer(timeInterval: Constants.timeInterval,
                                     target: self,
                                     selector: #selector(fetchRandomGif),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func endTimer() {
        timer.invalidate()
    }
    
    func fetchGifs(by searchQuery: String) {
        gifBackendService.fetchQueue.async { [weak self] in
            guard let self = self else { return }
            
            self.gifBackendService.getGif(by: searchQuery) { searchResults in
                switch searchResults {
                case .success(let models):
                    self.presenter.presentGifSearchResults(models)
                case .failure(let error):
                    print("Error occured: \(error)")
                }
            }
        }
    }
    
    func openGifDetailsModule(_ viewModel: GifItemViewModel) {
        presenter.presentGifDetailsModule(viewModel)
    }
}
