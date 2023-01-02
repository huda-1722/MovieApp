//
//  PopularMoviesCollectionCell.swift
//  MovieApp
//
//  Created by Huda  on 26/12/22.
//

import UIKit
import SDWebImage

class PopularMoviesCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    //MARK: - CELL LIFE CYCLE
    //======================
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.layer.cornerRadius = 20
        setFont()
        // Initialization code
    }
    
    private func setFont() {
        movieTitle.font = AppFonts.SourceSansProSemiBold.withSize(17)
        movieRating.font = AppFonts.SourceSansProSemiBold.withSize(17)
    }
    
    //MARK: - populate Cell Data
    //===========================
    func populateData(data : CommonMovieResult) {
        movieTitle.text = data.title
        if let rating = data.voteAverage {
            let c: String = String(format: "%.1f", rating)
            movieRating.text =  c + "/10"
        }
        let urlStr = "https://image.tmdb.org/t/p/w500" + (data.posterPath ?? "")
        moviePoster.sd_setImage(with: URL(string: urlStr))
    }
}
