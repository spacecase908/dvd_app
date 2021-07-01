//
//  ReccomendationViewController.swift
//  MovieApp
//
//  Created by user194382 on 5/26/21.
//

import UIKit

class ReccomendationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    @IBOutlet weak var tableView: UITableView!
    var collection: [Film] = []
    var myCollection: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
     
    override func viewWillAppear(_ animated: Bool) {
        myCollection = []
        for f in collection {
            if (f.collect == true) {
                myCollection.append(f)
            }
        }
        self.tableView.reloadData()
        print(myCollection)
        print("hello")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailView2") {
            guard let destination = segue.destination as? DetailViewController,
                  let selectedIndexPath = self.tableView.indexPathForSelectedRow,
                  let confirmedCell = self.tableView.cellForRow(at: selectedIndexPath) as? FilmCell
                  else { return }
        

            let confirmedFilm = confirmedCell.film
            destination.film = confirmedFilm
            print(confirmedFilm?.name)
        }
    }
}




extension ReccomendationListViewController: UITableViewDataSource {
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
