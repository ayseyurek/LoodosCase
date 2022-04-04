//
//  ViewController.swift
//  LoodosCase
//
//  Created by Ayşe YÜREK on 2.04.2022.
//

import UIKit
import Lottie

final class MainViewController: UIViewController, SearchViewModelDelegate {
  
    private var currentPage = 1
    private var currentQuery = ""
    private let searchViewModel = SearchViewModel()
    private let searchController = UISearchController()
    private var tableView = UITableView()
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel.delegate = self
        navigationController?.isNavigationBarHidden = true
        let animation = Animation.named("movieLoading")
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.backgroundColor = .clear
        animationView.play { _ in
            self.navigationController?.isNavigationBarHidden = false
            self.configureTableView()
            self.prepareNavigationBar()
        }
    }
    func getSearchResults() {
       reloadTableView()
    }
    
    private func configureTableView(){
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.loadNib(name: SearchTableViewCell.reuseIdentifier), forCellReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    private func prepareNavigationBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {return}
        detailVC.imdbID = searchViewModel.results[indexPath.row].imdbId
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == searchViewModel.results.count - 2 {
            currentPage += 1
            searchViewModel.searchRequest(with: currentQuery, page: currentPage)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.configure(image: searchViewModel.results[indexPath.row].poster, name: searchViewModel.results[indexPath.row].title, type: searchViewModel.results[indexPath.row].type)
        
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            currentQuery = searchText
            currentPage = 1
            searchViewModel.results.removeAll()
            reloadTableView()
            searchViewModel.searchRequest(with: searchText,page: currentPage)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentQuery = ""
        currentPage = 1
        searchViewModel.results.removeAll()
        reloadTableView()
    }
}

