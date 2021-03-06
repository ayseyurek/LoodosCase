//
//  MovieDetailView.swift
//  LoodosCase
//
//  Created by Ayşe YÜREK on 2.04.2022.
//

import UIKit
import Kingfisher
import Firebase

final class MovieDetailViewController: UIViewController, MovieDetailViewModelDelegate {
    
    // Constants
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!

    
    let movieDetailViewModel = MovieDetailViewModel()
    var imdbID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetailViewModel.delegate = self
        movieDetailViewModel.fetchDetails(with: imdbID)
    }
    
    func loadDetails(with model: MovieDetailModel) {
        Analytics.logEvent("movie_detail", parameters:
                            model.dictionary)
        guard let imageURL = URL(string: model.Poster) else {return}
        self.movieImageView.kf.indicatorType = .activity
        self.movieImageView.kf.setImage(with: imageURL)
        self.movieNameLabel.text = model.Title
        self.plotLabel.text = model.Plot
    }
}
