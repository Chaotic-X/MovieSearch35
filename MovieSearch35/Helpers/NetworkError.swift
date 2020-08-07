//
//  NetworkError.swift
//  MovieSearch35
//
//  Created by Alex Lundquist on 8/7/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

enum NetworError: LocalizedError {
  
  case invalidURL
  case thrownError(Error)
  case noData
  case unableToDecode
  
  var errorDescription: String? {
    switch self {
      case .invalidURL:
        return "The server failed to reach the URL. DUDE!? Where's your Movie?"
      case .thrownError(let error):
        return "There was an error: \(error.localizedDescription)"
      case .noData:
        return "Data failed to Load"
      case .unableToDecode:
        return "There was an error when loading or decoding the data"
    } //End Switch
  } //End errorDescription Computed Property
} //End of enum
