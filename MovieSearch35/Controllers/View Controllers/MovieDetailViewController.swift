//
//  MovieDetailViewController.swift
//  MovieSearch35
//
//  Created by Alex Lundquist on 8/7/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

  //MARK: -Outlets
  @IBOutlet weak var movieBackDropImage: UIImageView!
  @IBOutlet weak var movieTitleLabel: UILabel!
  @IBOutlet weak var movieReleaseDateLabel: UILabel!
  @IBOutlet weak var movieRatingLabel: UILabel!
  @IBOutlet weak var movieSummary: UILabel!
  
  
  var receivedMovie: Movie?
  
    override func viewDidLoad() {
        super.viewDidLoad()
      updateView()

    }
  
  //MARK: -Setup UP View
  func updateView() {
    guard let receivedMovie = receivedMovie,
      let backDropPath = receivedMovie.movieBackDrop else { return }
    MovieController.fetchImage(for: backDropPath) { (results) in
      DispatchQueue.main.async {
        switch results {
          case .success(let backDrop):
            self.movieBackDropImage.image = backDrop
          case .failure(let error):
           print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        } //End Switch
        self.movieTitleLabel.text = receivedMovie.movieTitle
        self.movieReleaseDateLabel.text = receivedMovie.movieReleaseDate
        self.movieRatingLabel.text = "Average Rating: \(receivedMovie.movieRating)"
        self.movieSummary.text = receivedMovie.movieSummary
        self.navigationController?.title = receivedMovie.movieTitle
      }
    }
  }
  
}
//let movieTitle: String
//let movieRating: Double
//let movieSummary: String
//let movieReleaseDate: String
//let moviePoster: String?
//let movieBackDrop: String?
