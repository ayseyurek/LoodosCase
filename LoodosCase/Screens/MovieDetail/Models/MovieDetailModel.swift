//
//  MovieDetailModel.swift
//  LoodosCase
//
//  Created by Ayşe Yürek on 02.04.2022.
//

import Foundation

struct MovieDetailModel: Decodable {
    
    let Runtime: String
    let Genre: String
    let Plot: String
    let Language: String
    let Poster: String
    let imdbID : String
    let Title: String
    let Year: String
    let imdbRating: String
    var dictionary: [String: String] {
        return ["Title":Title,
                "Year":Year,
                "Runtime":Runtime,
                "Genre":Genre,
                "Plot":Plot,
                "Language":Language,
                "Poster":Poster,
                "imdbID":imdbID]
    }

}
