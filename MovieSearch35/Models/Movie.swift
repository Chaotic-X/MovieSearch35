//
//  Movie.swift
//  MovieSearch35
//
//  Created by Alex Lundquist on 8/7/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

struct TopLevelObject: Codable {
  let results: [Movie]
}

struct Movie: Codable {
  let movieTitle: String
  let movieRating: Double
  let movieSummary: String
  let movieReleaseDate: String
  let moviePoster: String?
  let movieBackDrop: String?
  
  enum CodingKeys: String, CodingKey {
    case movieTitle = "title"
    case movieRating = "vote_average"
    case movieSummary = "overview"
    case movieReleaseDate = "release_date"
    case moviePoster = "poster_path"
    case movieBackDrop = "backdrop_path"
  }
}
