//
//  PosterViewController.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/13/23.
//

import UIKit
import Nuke

class PosterViewController: UIViewController, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        let imageUrl = movie.poster_path
        Nuke.loadImage(with: imageUrl, into: cell.posterImage)
        return cell
    }
    
    
    var movies: [Movie] = []
    var config: Config = Config(poster_sizes: [], secure_base_url: "")

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=f8b8c8b359d3fe02f014aea8e9587e87")!
        let request = URLRequest(url: url)
        let configUrl = URL(string: "https://api.themoviedb.org/3/configuration?api_key=f8b8c8b359d3fe02f014aea8e9587e87")!
        let configRequest = URLRequest(url: configUrl)
        
        let preTask = URLSession.shared.dataTask(with: configRequest) { [weak self] data, response, error in
            if let error = error {
                print("Network Error : \(error.localizedDescription)")
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ConfigResponse.self, from: data)
                self?.config = response.images
            } catch {
                print("❌ Error parsing JSON: \(error)")
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Network Error : \(error.localizedDescription)")
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data)
                let movies = response.results
                let modifiedMovies = movies.map { movie -> Movie in
                    let modifiedUrl = "https://image.tmdb.org/t/p/w780/" + movie.poster_path.path()
                    return Movie(original_title: movie.original_title, backdrop_path: movie.backdrop_path, poster_path: URL(string: modifiedUrl)!, overview: movie.overview, vote_average: movie.vote_average, vote_count: movie.vote_count)
                }
                DispatchQueue.main.async {
                    self?.movies = modifiedMovies
                    self?.collectionView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error)")
            }
            
        }
        preTask.resume()
        task.resume()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 1
        let numberOfColumns: CGFloat = 3
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColumns - 1)) / numberOfColumns
        layout.itemSize = CGSize(width: width, height: width)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UICollectionViewCell,
           let indexPath = collectionView.indexPath(for: cell),
           let detailCont = segue.destination as? DetailViewController {
            let movie = movies[indexPath.row]
            detailCont.movie = movie
        }
    }

}
