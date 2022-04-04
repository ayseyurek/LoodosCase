//
//  MovieDetailViewModel.swift
//  LoodosCase
//
//  Created by Ayşe Yürek
//

import Foundation


final class MovieDetailViewModel {
    
    weak var delegate: MovieDetailViewModelDelegate?
    func fetchDetails(with id: String) {
        Service.shared.fetchDetails(with: id) { model in
            self.delegate?.loadDetails(with: model)
        }
    }
}
