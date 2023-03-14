//
//  MovieCell.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/5/23.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieText: UITextView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(movie: Movie) {
        movieLabel.text = movie.original_title
        movieText.text = movie.overview
        Nuke.loadImage(with: movie.poster_path, into: movieImage)
    }

}
