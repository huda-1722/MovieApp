//
//  MovieSearchCollectionCell.swift
//  MovieApp
//
//  Created by Huda  on 01/01/23.
//

import UIKit

class MovieSearchCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    //=====================================
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    //MARK: - CELL LIFE CYCLE
    //======================
    override func awakeFromNib() {
        super.awakeFromNib()
        moviePoster.layer.cornerRadius = 20
        // Initialization code
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
