//
//  SearchViewModel.swift
//  LoodosCase
//
//  Created by Ayşe YÜREK on 2.04.2022.
//

import Foundation


class SearchViewModel {
    
    var results = [SearchResult]()
    weak var delegate: SearchViewModelDelegate?
    func searchRequest(with query: String,page: Int) {
        Service.shared.searchMovies(with: query,page: page) { result in
            self.results.append(contentsOf: result.Search)
            self.delegate?.getSearchResults()
        }
    }
}
