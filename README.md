# MoviesAppUIKit

`MoviesAppUIKit` is a lightweight UIKit sample app focused on learning reactive networking with **Combine**.

## Purpose

This project is meant to share practical knowledge through simple examples, especially:

- API consumption with `URLSession` + Combine
- Publisher and Subscriber flow
- Input handling with `debounce` for search

## What this project demonstrates

- A clean movie search flow using OMDb API
- ViewModel-driven state updates with Combine publishers
- Easy-to-read patterns for asynchronous data handling in UIKit

## OMDb API Key (Free)

To run movie requests, get a free API key here:

- https://www.omdbapi.com/apikey.aspx

The free plan provides **up to 1000 daily requests**.

## Quick Combine examples

### 1. API consumption (Publisher)

```swift
URLSession.shared.dataTaskPublisher(for: url)
    .map(\.data)
    .decode(type: MovieResponse.self, decoder: JSONDecoder())
    .eraseToAnyPublisher()
```

### 2. Subscriber in a ViewModel or ViewController

```swift
movieService.search(query: text)
    .sink(receiveCompletion: { completion in
        // handle finished / error
    }, receiveValue: { movies in
        // update UI state
    })
    .store(in: &cancellables)
```

### 3. Debounce for search input

```swift
searchTextSubject
    .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
    .removeDuplicates()
    .sink { [weak self] text in
        self?.searchMovies(with: text)
    }
    .store(in: &cancellables)
```

## Goal

Keep a minimal, approachable codebase that helps developers quickly understand Combine basics in a real UIKit app.
