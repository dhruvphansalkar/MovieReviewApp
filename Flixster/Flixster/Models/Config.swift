//
//  Config.swift
//  Flixster
//
//  Created by Dhruv Phansalkar on 3/13/23.
//

import Foundation

struct Config: Decodable {
    let poster_sizes: [String]
    let secure_base_url: String
}

struct ConfigResponse: Decodable {
    let images : Config
}
