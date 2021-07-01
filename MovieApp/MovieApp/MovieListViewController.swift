//
//  ViewController.swift
//  AngryBirds
//
//  Created by user194382 on 4/5/21.
//  Search adapted from Ray Wenderlich UISearch Tutorial
//

import UIKit
import CoreData

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var collection: [Film] = []
    var myCollection: [Film] = []
    var filmService: FilmService!
    var indicator = UIActivityIndicatorView(style: .large)
    var filteredFilms: [Film] = []
    var testCollection: [NSManagedObject] = []
    
    let searchcontroller = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
              
        
        searchcontroller.searchResultsUpdater = self
        searchcontroller.obscuresBackgroundDuringPresentation = false
        searchcontroller.searchBar.placeholder = "Search Films"
        navigationItem.searchController = searchcontroller
        definesPresentationContext = true
        

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        indicator.center = self.view.center
        indicator.startAnimating()
        self.view.addSubview(indicator)
        self.tableView.reloadData()
        
        
        indicator.stopAnimating()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        tableView.reloadData()
        print(self.collection.count)

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailView") {
            guard let destination = segue.destination as? DetailViewController,
                  let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                  let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? FilmCell
                  else { return }
        

            let confirmedFilm = confirmedCell.film
            destination.film = confirmedFilm
            destination.myCollection = myCollection
            
        }
        
        if (segue.identifier == "add") {
            guard let destination = segue.destination as? AddMovieViewController
            else {return}
            
            destination.collection = collection

        }
        

        
        
    }
    @IBAction func goToAddFilmView(_ sender: Any) {
        
        let addFilmView = storyboard?.instantiateViewController(withIdentifier: "addFilmView") as! AddMovieViewController
        addFilmView.callback = {
            Film in self.collection.append(Film)
        }
        
        self.present(addFilmView, animated: true, completion: nil)

        
    }
    
    func passCollection() {
        let vc = CollectionListViewController(nibName: "Collection", bundle: nil)
        vc.myCollection = self.collection
        navigationController?.pushViewController(vc, animated: true)
    }
    var isSearchBarEmpty: Bool {
        return searchcontroller.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchcontroller.isActive && !isSearchBarEmpty
    }
    
    
    func filterContentForSearchText( searchText: String) {
        filteredFilms = collection.filter { (film: Film) -> Bool in
            return film.search.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
        
    }
    
}

extension MovieListViewController: UITableViewDataSource {
    //MARK: DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredFilms.count
        }
        
        return self.collection.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "filmCell") as! FilmCell
        let currentFilm: Film
        if isFiltering {
            currentFilm = filteredFilms[indexPath.row]
        } else {
            currentFilm = self.collection[indexPath.row]
        }
        
        
        
        cell.film = currentFilm
        
        return cell
        
    }
}

extension MovieListViewController: UITableViewDelegate {
    //MARK: Delegate
    
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let classic = classicAction(at: indexPath)
            return UISwipeActionsConfiguration(actions: [classic])

            
        }
    
    func classicAction(at indexPath: IndexPath) -> UIContextualAction {
        let cell = self.tableView.cellForRow(at: indexPath) as? FilmCell
        let confirmedFilm = cell?.film
        let action = UIContextualAction(style: .normal, title: "Watched!") { (action, view, completion) in
            confirmedFilm?.watched = !confirmedFilm!.watched
            cell?.accessoryType = confirmedFilm!.watched ? .checkmark : .none
            completion(true)
        }
        action.backgroundColor = confirmedFilm!.watched ? .gray : .systemPink
        return action
    }
    


}

extension MovieListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}
