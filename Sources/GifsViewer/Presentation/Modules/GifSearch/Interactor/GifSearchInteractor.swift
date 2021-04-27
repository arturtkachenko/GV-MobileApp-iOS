//
//  GifSearchInteractor.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation

// MARK: - Protocols

protocol GifSearchInteractorProtocol: InteractorProtocol {
    
    func fetchGifs(by searchQuery: String)
    func startTimer()
    func endTimer()
}

// MARK: - Implementation

final class GifSearchInteractor: BaseInteractor {
    
    // MARK: - Constants
    
    private enum Request {
        
        static let timeInterval: TimeInterval = 10.0
    }
    
    // MARK: - Properties
    
    private let presenter: GifSearchPresenterProtocol
    private let gifBackendService: GifBackendServiceProtocol
    
    private var timer: Timer?
    
    // MARK: - Initializers
    
    init(presenter: GifSearchPresenterProtocol, gifBackendService: GifBackendServiceProtocol) {
        self.presenter = presenter
        self.gifBackendService = gifBackendService
    }
    
    // MARK: - Actions
    
    @objc private func fetchRandomGif() {
        gifBackendService.fetchQueue.async { [weak self] in
            self?.gifBackendService.getRandomGif { randomGif in
                switch randomGif {
                case let .success(model):
                    DispatchQueue.main.async {
                        self?.presenter.presentRandomGif(model)
                    }
                case let .failure(error):
                    print("Error occured: \(error)")
                }
            }
        }
    }
}

// MARK: - GifSearchInteractorProtocol

extension GifSearchInteractor: GifSearchInteractorProtocol {
    
    func fetchGifs(by searchQuery: String) {
        gifBackendService.fetchQueue.async {
            self.gifBackendService.getGifs(by: searchQuery) { [weak self] searchResults in
                switch searchResults {
                case let .success(models):
                    DispatchQueue.main.async {
                        let screenModel = GifSearchScreenModel(items: models,
                                                               onSelectActionTriggered: { index in
                                                                guard let model = models[safe: index] else { return }
                                                                let context = GifDetailsContext(model: model)
                                                                self?.presenter.presentGifDetailsModule(context)
                                                               })
                        self?.presenter.presentGifSearchResults(screenModel)
                    }
                case let .failure(error):
                    print("Error occured: \(error)")
                }
            }
        }
    }
    
    func startTimer() {
        fetchRandomGif()
        timer = Timer.scheduledTimer(timeInterval: Request.timeInterval,
                                     target: self,
                                     selector: #selector(fetchRandomGif),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func endTimer() {
        timer?.invalidate()
    }
}
