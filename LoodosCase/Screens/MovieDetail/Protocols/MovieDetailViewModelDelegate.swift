//
//  MovieDetailViewModelDelegate.swift
//  LoodosCase
//
//  Created by Ayşe YÜREK on 2.04.2022.
//

import Foundation

protocol MovieDetailViewModelDelegate:AnyObject {
    func loadDetails(with model: MovieDetailModel)
}
