//
//  HTTPClient.swift
//  MoviesAppUIKit
//
//  Created by Thiago Castro on 02/03/26.
//


import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
}

class HTTPClient {
    
    func fetchMovies(search: String) -> AnyPublisher<[Movie], Error> {
        
        guard let encodedSearch = search.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&apikey=YOUR_API_KEY")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .map(\.search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movie], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
    
}
