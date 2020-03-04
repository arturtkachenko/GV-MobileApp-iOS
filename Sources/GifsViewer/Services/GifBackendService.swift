//
//  GifBackendService.swift
//  GifsViewer
//
//  Created by Artur Tkachenko on 1/30/20.
//  Copyright © 2020 Artur Tkachenko. All rights reserved.
//

import Foundation
import Alamofire

enum ServiceRequest {
    static let limitItems: Int = 100
    
    case random
    case search
    
    var name: String {
        switch self {
        case .random:
            return "random"
        default:
            return "search"
        }
    }
}

protocol GifBackendService {
    
    var fetchQueue: DispatchQueue { get }
    func getRandomGif(_ completion: @escaping (Result<GifItemModel>) -> Void)
    func getGif(by searchQuery: String, _ completion: @escaping (Result<[GifItemModel]>) -> Void)
}

final class GifBackendServiceImplementation: GifBackendService {
    
    private let apiPath: String = "https://api.giphy.com/v1/gifs/"
    private let apiKey: String = "dc6zaTOxFJmzC"
    
    private(set) var fetchQueue = DispatchQueue(label: "com.GifBackendService.queue", qos: .utility)
    
    func getRandomGif(_ completion: @escaping (Result<GifItemModel>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            guard let url = URL(string: (self.apiPath + ServiceRequest.random.name)) else { return }
            
            let parameters: [String: String] = ["api_key": self.apiKey]
            
            Alamofire.request(url, parameters: parameters).response { response in
                
                guard let data = response.data else { return }
                
                do {
                    let gifData = try JSONDecoder().decode(GifDataModel.self, from: data)
                    completion(.success(gifData.data))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getGif(by searchQuery: String, _ completion: @escaping (Result<[GifItemModel]>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            guard let url = URL(string: (self.apiPath + ServiceRequest.search.name)) else { return }
            
            let parameters: [String: String] = ["api_key": self.apiKey,
                                                "q": searchQuery,
                                                "limit": "\(ServiceRequest.limitItems)"]
            
            Alamofire.request(url, parameters: parameters).response { response in
                
                guard let data = response.data else { return }
                
                do {
                    let gifData = try JSONDecoder().decode(GifSearchDataModel.self, from: data)
                    completion(.success(gifData.data))
                } catch let error {
                    print("Error occured: \(error)")
                    completion(.failure(error))
                }
            }
        }
    }
}
