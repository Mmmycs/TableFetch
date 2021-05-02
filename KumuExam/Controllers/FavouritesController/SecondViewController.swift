//
//  SecondViewController.swift
//  KumuExam
//
//  Created by Macbook pro on 28/04/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import UIKit
import CoreData
class SecondViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet var tableView: UITableView!
    
    
    //MARK: - Properties
    
    //Data for the table
    var items:[MovieList]?
    //Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    var viewModel: SecondVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup UI
        setTableUI()
        viewModel = SecondVM(view: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sortFavourites()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTableUI() {
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - Show/Sort lists of favourites movies
    func sortFavourites() {
        do {
            let request = MovieList.fetchRequest() as NSFetchRequest<MovieList>
            let pred = NSPredicate(format: "isFavourite CONTAINS true")
            request.predicate = pred
            self.items = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            print("failed sort")
        }
    }
}

extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "favourites_cell", for: indexPath) as! FavouritesTableViewCell
        let movieList = self.items?[indexPath.row]
        cell.movieTitleLbl.text = movieList?.movieTitle
        let artwork: String = movieList?.artwork ?? ""
        let url = URL(string: artwork)
        cell.artworkImg.kf.setImage(with: url)
        return cell
    }
}

extension SecondViewController: SecondViewProtocol {
    func reloadTable(items: [MovieList]?) {
        self.items = items
        self.tableView.reloadData()
    }
}
