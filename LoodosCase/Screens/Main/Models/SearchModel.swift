//
//  SearchModel.swift
//  LoodosCase
//
//  Created by Ayşe Yürek on 02.04.2022.
//

import Foundation

struct SearchModel: Decodable {
    let Search: [SearchResult]
}

struct SearchResult: Decodable {
    
    let title: String
    let year: String
    let imdbId: String
    let type: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case type = "Type"
        case poster = "Poster"
    }
}
