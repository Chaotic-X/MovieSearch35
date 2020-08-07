//
//  MovieListTableViewController.swift
//  MovieSearch35
//
//  Created by Alex Lundquist on 8/7/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class MovieListTableViewController: UITableViewController {
  //MARK: -Outlets
  @IBOutlet weak var searchForMovieSearchBar: UISearchBar!
  
  //MARK: -Properties
  var movies: [Movie] = []
  
  //MARK: -LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    searchForMovieSearchBar.delegate = self
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return movies.count
  } //End of Number of Rows in Section
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell()}
    let movies = self.movies[indexPath.row]
    cell.movieSearch = movies
    return cell
  } //End of Cell
  // MARK: - Navigation
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //Setting Custom Back Button Text
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "Back", style: .plain, target: nil, action: nil)
    if segue.identifier == "toDetailVC" {
      guard let indexPath = tableView.indexPathForSelectedRow,
        let destinationVC = segue.destination as? MovieDetailViewController else { return }
      let movieToSend = movies[indexPath.row]
      destinationVC.receivedMovie = movieToSend
    }
  } //End of Prepare for Segue
  
} //End of MovieListTableViewControlelr

//MARK: -Extensions
extension MovieListTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = searchForMovieSearchBar.text, !searchTerm.isEmpty else { return }
    MovieController.fetchMovie(for: searchTerm){ (results) in
      DispatchQueue.main.async {
        switch results {
          case .success(let movies):
            self.movies = movies
            self.tableView.reloadData()
          case .failure(let error):
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        } //End of Switch
      } //End of Dispatch
    } //End of FetchMovie
  } //End of SearcBarchClicked
} //End of Extension
