//
//  NetworkServiceManager.swift
//  NewsApp
//
//  Created by asmaa abdelfattah on 01/11/2024.
//

import Foundation
import Combine
class NetworkServiceManager{
    
    private static var networkService : NetworkServiceManager?
 
    public static func getInstance()->NetworkServiceManager{
        if networkService == nil {
            networkService = NetworkServiceManager()
        }
        return networkService!
    }
    
    var articlePublisher: AnyPublisher<Articles,Error>{
        guard let url = URL(string: Networking.articles("2024-10-1", "tesla").fullPath)
        else {return Fail(error: URLError(.badURL)).eraseToAnyPublisher()}
                print(url)
        return URLSession.shared.dataTaskPublisher(for: url).map {$0.data}.decode(type: Articles.self, decoder: JSONDecoder()).receive(on: RunLoop.main).eraseToAnyPublisher()
    }
    
}
