//
//  ViewController.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/5/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    var movies: [Movie] = []
    var config: Config = Config(poster_sizes: [], secure_base_url: "")
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
            
        let task = URLSession.shared.dataTask(with: request) { [weak self] data1, response, error in
            if let error = error {
                print("Network Error : \(error.localizedDescription)")
            }
            guard let data1 = data1 else {
                print("data is nil")
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieResponse.self, from: data1)
                let movies = response.results
                let modifiedMovies = movies.map { movie -> Movie in
                    let modifiedUrl = "https://image.tmdb.org/t/p/w780/" + movie.poster_path.path()
                    return Movie(original_title: movie.original_title, backdrop_path: movie.backdrop_path, poster_path: URL(string: modifiedUrl)!, overview: movie.overview, vote_average: movie.vote_average, vote_count: movie.vote_count)
                }

                DispatchQueue.main.async {
                    self?.movies = modifiedMovies
                    self?.tableView.reloadData()
                }
            } catch {
                print("❌ Error parsing JSON: \(error)")
            }
            
        }
        preTask.resume()
        task.resume()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let detailCont = segue.destination as? DetailViewController {
            let movie = movies[indexPath.row]
            detailCont.movie = movie
        }
    }
    
}

