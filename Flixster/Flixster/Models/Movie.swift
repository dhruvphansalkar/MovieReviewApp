//
//  Movie.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/5/23.
//

import Foundation

struct Movie: Decodable {
    let original_title: String
    let backdrop_path: String
    var poster_path: URL
    let overview: String
    let vote_average: Float
    let vote_count: Int
}

struct MovieResponse: Decodable {
    let results : [Movie]
}

extension Movie {
        static var mockMovies: [Movie] = [
                Movie(original_title: "Knock at the Cabin", backdrop_path: "/22z44LPkMyf5nyyXvv8qQLsbom.jpg", poster_path: URL(string:"http://52.33.176.184/tmdbbd/1GrURa0tEBIBjJ2EbeRsMP65YPK.jpg")!, overview: "While vacationing at a remote cabin, a young girl and her two fathers are taken hostage by four armed strangers who demand that the family make an unthinkable choice to avert the apocalypse. With limited access to the outside world, the family must decide what they believe before all is lost.", vote_average: 6.6, vote_count: 2611),
                Movie(original_title: "Black Panther: Wakanda Forever", backdrop_path: "/xDMIl84Qo5Tsu62c9DGWhmPI67A.jpg", poster_path: URL(string:"http://52.33.176.184/tmdbbd/1EGJSlQsUxh6M1FfUEDby10mZ5q.jpg")!, overview: "Queen Ramonda, Shuri, M’Baku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King T’Challa’s death.  As the Wakandans strive to embrace their next chapter, the heroes must band together with the help of War Dog Nakia and Everett Ross and forge a new path for the kingdom of Wakanda.", vote_average: 7.4, vote_count: 2838),
                Movie(original_title: "Puss in Boots: The Last Wish", backdrop_path: "/b1Y8SUb12gPHCSSSNlbX4nB3IKy.jpg", poster_path: URL(string:"http://52.33.176.184/tmdbbd/1K7jIv3vy6dIXwo0CQNwokLeJc5.jpg")!, overview: "Puss in Boots discovers that his passion for adventure has taken its toll: He has burned through eight of his nine lives, leaving him with only one life left. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.", vote_average: 8.4, vote_count: 8002),
                Movie(original_title: "Plane", backdrop_path: "/9Rq14Eyrf7Tu1xk0Pl7VcNbNh1n.jpg", poster_path: URL(string:"http://52.33.176.184/tmdbbd/1N08Nac58pyOxtD3FtEE1KQYm0l.jpg")!, overview: "After a heroic job of successfully landing his storm-damaged aircraft in a war zone, a fearless pilot finds himself between the agendas of multiple militias planning to take the plane and its passengers hostage.", vote_average: 6.9, vote_count: 4622),
                Movie(original_title: "Little Dixie", backdrop_path: "/A2avUoNFstnBhAnHiogXQs4c9Bt.jpg", poster_path: URL(string:"http://52.33.176.184/tmdbbd/1NBNqKdqm6Ext9QSqh9oL7LB3ms.jpg")!, overview: "Valeria's joy at becoming a first-time mother is quickly taken away when she's cursed by a sinister entity. As danger closes in, she's forced deeper into a chilling world of dark magic that threatens to consume her.", vote_average: 6.8, vote_count: 6423)
            ]
}
