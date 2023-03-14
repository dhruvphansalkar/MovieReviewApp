//
//  Poster.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/13/23.
//

import Foundation

struct PosterResponse: Decodable {
    let results : [Poster]
}

struct Poster: Decodable {
    let poster_path: URL
}

