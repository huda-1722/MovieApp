//
//  MovieDetailVC.swift
//  MovieApp
//
//  Created by Huda  on 28/12/22.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var movieDetailView: UIView!
    @IBOutlet weak var languages: UILabel!
    @IBOutlet weak var languageValue: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var voteCountValue: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var runningTime: UILabel!
    @IBOutlet weak var ratingScore: UILabel!
    @IBOutlet weak var ratingScoreValue: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var overView: UILabel!
    @IBOutlet weak var actor3: UILabel!
    @IBOutlet weak var actor4: UILabel!
    @IBOutlet weak var actor5: UILabel!
    @IBOutlet weak var roleOfActor3: UILabel!
    @IBOutlet weak var roleOfActor4: UILabel!
    @IBOutlet weak var roleOfActor5: UILabel!
    @IBOutlet weak var roleOfActor2: UILabel!
    @IBOutlet weak var actor2: UILabel!
    @IBOutlet weak var roleOfActor1: UILabel!
    @IBOutlet weak var actor1: UILabel!
    
    //MARK: PROPERTIES
    //=================================
    var viewModel : MovieDeatilVM?
    var movieId : Int?
    
    // MARK: - Lifecycle
    //====================================
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    //MARK: - IBAction
    @IBAction func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension for Private functions
//========================================
extension MovieDetailVC {
    private func setFont() {
        ratingScoreValue.font = AppFonts.SourceSansProLight.withSize(15)
        languageValue.font = AppFonts.SourceSansProLight.withSize(15)
        voteCountValue.font = AppFonts.SourceSansProLight.withSize(15)
        ratingScore.font = AppFonts.SourceSansProExtraLight.withSize(15)
        voteCount.font = AppFonts.SourceSansProExtraLight.withSize(15)
        languages.font = AppFonts.SourceSansProExtraLight.withSize(15)
        releaseDate.font = AppFonts.SourceSansProLight.withSize(13)
        runningTime.font = AppFonts.SourceSansProLight.withSize(13)
        genre.font = AppFonts.SourceSansProLight.withSize(13)
        runningTime.font = AppFonts.SourceSansProLight.withSize(13)
        overView.font = AppFonts.SourceSansProLight.withSize(12)
        movieTitle.font = AppFonts.SourceSansProBold.withSize(28)
    }
    private func minutesToHoursAndMinutes(_ minutes: Int) -> (hours: Int , leftMinutes: Int) {
        return (minutes / 60, (minutes % 60))
    }
    private func initialSetUp() {
        movieDetailView.layer.cornerRadius = 20
        movieDetailView.layer.masksToBounds = true
        viewModel = MovieDeatilVM(movieId: movieId ?? 0)
        viewModel?.delegate = self
        setFont()
    }
}
// MARK: - Extension of PassMovieData
//========================================
extension MovieDetailVC : PassMovieData {
    
    func didGetMovieData() {
        let movieData = viewModel?.getData()
        movieTitle.text = movieData?.title
        if movieData?.originalLanguage == "en" {
            languageValue.text = "English"
        } else {
            languageValue.text = "Others"
        }
        runningTime.text = movieData?.runtime?.description
        voteCountValue.text = movieData?.voteCount?.description
        releaseDate.text = movieData?.releaseDate
        ratingScoreValue.text = movieData?.voteAverage?.description
        overView.text = movieData?.overview
        let housrAndMinutes = minutesToHoursAndMinutes(Int(movieData?.runtime ?? 0))
        runningTime.text = String(housrAndMinutes.hours) + "h" + " " + String(housrAndMinutes.leftMinutes) + "m"
        for i in 0..<(movieData?.genres?.count ?? 0 ) {
            genre.text = (genre.text ?? "" ) + (movieData?.genres?[i].name ?? "")
            if i != (movieData?.genres?.count ?? 0)  - 1 {
                genre.text! += ", "
            }
        }
        for i in 0..<5 {
            if i == 0 {
                actor1.text = movieData?.credits?.cast?[i].name
                roleOfActor1.text = movieData?.credits?.cast?[i].character
            } else if i == 1 {
                actor2.text = movieData?.credits?.cast?[i].name
                roleOfActor2.text = movieData?.credits?.cast?[i].character
            } else if i == 2 {
                actor3.text = movieData?.credits?.cast?[i].name
                roleOfActor3.text = movieData?.credits?.cast?[i].character
            } else if i == 3 {
                actor4.text = movieData?.credits?.cast?[i].name
                roleOfActor4.text = movieData?.credits?.cast?[i].character
            } else {
                actor5.text = movieData?.credits?.cast?[i].name
                roleOfActor5.text = movieData?.credits?.cast?[i].character
            }
        }
        
        let urlStr = "https://image.tmdb.org/t/p/w500" + (movieData?.posterPath ?? "")
        moviePoster.sd_setImage(with: URL(string: urlStr))
    }
}
