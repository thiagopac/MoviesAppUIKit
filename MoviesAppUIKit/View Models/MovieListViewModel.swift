//
//  MovieListViewModel.swift
//  MoviesAppUIKit
//
//  Created by Thiago Castro on 02/03/26.
//


import Foundation
import Combine

class MovieListViewModel {
    
    @Published private(set) var movies: [Movie] = []
    @Published var loadingCompleted: Bool = false
    
    private let httpClient: HTTPClient
    private var cancellables = Set<AnyCancellable>()
    
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        setupSearchPublisher()
    }
    
    func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.loadMovies(search: searchText)
            }.store(in: &cancellables)
    }
    
    func setSearchText(_ searchText: String) {
        searchSubject.send(searchText)
    }
    
    func loadMovies(search: String) {
        httpClient.fetchMovies(search: search)
            .sink { [weak self] completion in
                switch completion {
                    case .finished:
                        self?.loadingCompleted = true
                    case .failure(let error ):
                        print(error)
                     
                }
            } receiveValue: { movies in
                self.movies = movies
            }.store(in: &cancellables)

    }
    
}
