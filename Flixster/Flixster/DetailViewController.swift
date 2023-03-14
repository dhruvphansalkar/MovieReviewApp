//
//  DetailViewController.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/5/23.
//

import UIKit
import Nuke

class DetailViewController: UIViewController {
    
    var movie: Movie!

    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var views: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = movie.original_title
        detailText.text = movie.overview
        stars.text = movie.vote_average.description
        views.text = movie.vote_count.description
        Nuke.loadImage(with: movie.poster_path, into: detailImage)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
