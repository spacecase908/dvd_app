//
//  File.swift
//  MovieApp
//
//  Created by user194382 on 5/10/21.
//

import UIKit
import CoreData

class CollectionListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var collection: [Film] = []
    var myCollection: [Film] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
     
    override func viewWillAppear(_ animated: Bool) {
        myCollection = []
        for f in collection {
            if (f.watchList == true) {
                myCollection.append(f)
            }
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailView2") {
            guard let destination = segue.destination as? DetailViewController,
                  let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                  let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? FilmCell
                  else { return }
        

            let confirmedFilm = confirmedCell.film
            destination.film = confirmedFilm

        }
    }
    
}




extension CollectionListViewController: UITableViewDataSource {
    //MARK: DataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myCollection.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "filmCell") as! FilmCell
        
        let currentFilm = self.myCollection[indexPath.row]
        
        
        cell.film = currentFilm
        
        return cell
        
    }
}


extension CollectionListViewController: UITableViewDelegate {
    //MARK: Delegate
    
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let classic = classicAction(at: indexPath)
            return UISwipeActionsConfiguration(actions: [classic])

            
        }
    
    func classicAction(at indexPath: IndexPath) -> UIContextualAction {
        let cell = self.tableView.cellForRow(at: indexPath) as? FilmCell
        let confirmedFilm = cell?.film
        let action = UIContextualAction(style: .normal, title: "Watched!") { (action, view, completion) in
                      
            confirmedFilm?.watched = true
            confirmedFilm?.watchList = false
            cell?.accessoryType = confirmedFilm!.watched ? .checkmark : .none
            completion(true)
        }
        action.backgroundColor = confirmedFilm!.watched ? .gray : .systemPink
        
        
        return action
    }
    


}
