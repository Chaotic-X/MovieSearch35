//
//  MovieTableViewCell.swift
//  MovieSearch35
//
//  Created by Alex Lundquist on 8/7/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  //MARK: -OutLets
  @IBOutlet weak var moviePosterImage: UIImageView!
  @IBOutlet weak var movieTitleLabel: UILabel!
  @IBOutlet weak var movieRatingLabel: UILabel!
  @IBOutlet weak var movieSummaryLabel: UILabel!
  
  //MARK: -Properties
  var movieSearch: Movie? {
    didSet{
      updateViewWithMovie()
    }
  } //End of movies

  //MARK: -Helper Methods
  
  func updateViewWithMovie() {
    guard let posterPath = movieSearch?.moviePoster else { return }
    MovieController.fetchImage(for: posterPath) { (results) in
      DispatchQueue.main.async {
        switch results {
          case.success(let image):
            self.moviePosterImage.image = image
          case .failure(let error):
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        } //End of Switch
        self.movieTitleLabel.text = self.movieSearch?.movieTitle
        self.movieRatingLabel.text = "Avg Rating: \(self.movieSearch?.movieRating ?? 0)"
        self.movieSummaryLabel.text = self.movieSearch?.movieSummary ?? "There was no Summary"
      } //End of Dispatch
    } //End of FetchImage
  } //End of UpdateView
} //End of Class
