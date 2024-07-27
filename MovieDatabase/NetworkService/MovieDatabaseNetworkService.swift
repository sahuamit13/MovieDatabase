//
//  MovieDatabaseNetworkService.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 26/07/24.
//

import Foundation

class MovieDatabaseNetworkService: MovieDatabaseNetworkServiceDelegate{
    func getMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(.success(movies))
            } catch {
                debugPrint("Error loading movies: \(error)")
                completion(.failure(error))
            }
        }else{
            completion(.failure(NetworkServiceError.error404))
        }
    }
    
    
}
