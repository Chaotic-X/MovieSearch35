//
//  MovieController.swift
//  MovieSearch35
//
//  Created by Alex Lundquist on 8/7/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation
import class UIKit.UIImage

class MovieController {
  //MARK: -Constants
  //MovieURL
  // - URL I am trying to make: https://api.themoviedb.org/3/search/movie?api_key=e897a469c06b5cf357ad9ab81d5ca73d&query=Jack%20Reacher
  static private let baseMovieURL = URL(string:"https://api.themoviedb.org/3/search/movie")
  //ImageURL
  // - URL I am trying to make: https://image.tmdb.org/t/p/w500/IfB9hy4JH1eH6HEfIgIGORXi5h.jpg
  static private let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")
  //apikey - Key
  static private let apiKeyKey = "api_key"
  //apikey - Value
  static private let apiKeyValue = "e897a469c06b5cf357ad9ab81d5ca73d"
   
  //MARK: -FetchMovie
  static func fetchMovie(for searchTerm: String, completion: @escaping(Result<[Movie], NetworError>) -> Void) {
    //1.) Build URL
    guard let baseURL = baseMovieURL else { return completion(.failure(.invalidURL))}
    //a: Build URL components
    var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
    //b:  appendingPathComponents -- not needed today
    //c: our query items - need URLComponents to allow us to append QueryItems
    //d: Build out our query items
    //e: Now create an array of those queryitems in the order in which they appear in the URL we are building
    components?.queryItems = [ URLQueryItem(name: apiKeyKey, value: apiKeyValue),
                               URLQueryItem(name: "query", value: searchTerm)]
    //f: Now put it all together calling the url property on "components" since its optional. Guard againts that
    guard let finalURL = components?.url else { return completion(.failure(.invalidURL))}
    print(finalURL.absoluteString)
    //2.) - Contact server by building our URLSession
    URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
      //3.) - Handle errors from the server
      if let error = error {
        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        return completion(.failure(.thrownError(error)))
      }
      //4.) - Check if data exists and guard against it
      guard let data = data else { return completion(.failure(.noData))}
//      print(String(data: data, encoding: .utf8) as Any)
      //5.) - Initialize the data in a do-catch
      do {
        let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
        let movies = topLevelObject.results
        print("Succes")
        return completion(.success(movies))
      } catch {
        return completion(.failure(.thrownError(error)))
      }
      //6.) - RESUME!!!
    }.resume() //End of URLSession
  } //End of FetchMovie
  
  //MARK: -FetchImage
  static func fetchImage(for imagePath: String, completion: @escaping (Result<UIImage, NetworError>) -> Void) {
    //1.) Build URL
    guard let imageURL = baseImageURL?.appendingPathComponent(imagePath) else { return completion(.failure(.invalidURL))}
    print(imageURL.absoluteString)
    //2.) - Contact server by building our URLSession
    URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
      //3.) - Handle errors from the server
      if let error = error {
        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        return completion(.failure(.thrownError(error)))
      }
      //4.) - Check if data exists and guard against it
      guard let data = data else { return completion(.failure(.noData))}
      //5.) - Initialize the data in a do-catch
      guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
      return completion(.success(image))
      //6.) - RESUME!!!
    }.resume() //End of URLSession
  } //End of FetchImage
} //End of Class

