//
//  MovieDatabaseDelegate.swift
//  MovieDatabase
//
//  Created by Amit Sahu on 27/07/24.
//

import Foundation

protocol MovieDatabaseDelegate: AnyObject{
    func reloadData(animation: Bool)
    func showMovieList(title: String, movies: [Movie])
    func showMovieDetails(movie: Movie)
}
extension MovieDatabaseDelegate{
    func reloadData(animation: Bool) {}
    func showMovieList(title: String, movies: [Movie]) {}
    func showMovieDetails(movie: Movie){}
}
protocol MovieDatabaseNetworkServiceDelegate: AnyObject{
    func getMovies(completion: @escaping (Swift.Result<[Movie],Error>)->Void)
}

enum NetworkServiceError: Error{
    case error404
}
extension NetworkServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .error404:
            return NSLocalizedString("404: File not found!.", comment: "Error: 404")
        }
    }
}
