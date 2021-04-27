//
//  GifBackendService.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Alamofire

protocol GifBackendServiceProtocol {
    
    var fetchQueue: DispatchQueue { get }
    
    func getRandomGif(_ completion: @escaping ArgumentedClosure<Result<GifItemModel>>)
    func getGifs(by searchQuery: String, _ completion: @escaping ArgumentedClosure<Result<[GifItemModel]>>)
}

final class GifBackendService: GifBackendServiceProtocol {
    
    private enum API {
        
        static let path = "https://api.giphy.com/v1/gifs/"
        static let key = "dc6zaTOxFJmzC"
        
        enum Request: String {
            
            static let limitItems = 100
            
            case random
            case search
        }
    }
    
    private(set) var fetchQueue = DispatchQueue(label: "com.GifBackendService.queue", qos: .utility)
    
    func getRandomGif(_ completion: @escaping ArgumentedClosure<Result<GifItemModel>>) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: (API.path + API.Request.random.rawValue)) else { return }
            let parameters = ["api_key": API.key]
            
            Alamofire.request(url, parameters: parameters).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let gifData = try decoder.decode(GifDataModel.self, from: data)
                    completion(.success(gifData.data))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getGifs(by searchQuery: String, _ completion: @escaping ArgumentedClosure<Result<[GifItemModel]>>) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: (API.path + API.Request.search.rawValue)) else { return }
            let parameters = ["api_key": API.key,
                              "q": searchQuery,
                              "limit": "\(API.Request.limitItems)"]
            
            Alamofire.request(url, parameters: parameters).response { response in
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let gifData = try decoder.decode(GifSearchDataModel.self, from: data)
                    completion(.success(gifData.data))
                } catch let error {
                    print("Error occured: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
}
