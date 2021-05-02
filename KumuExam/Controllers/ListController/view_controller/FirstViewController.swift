//
//  FirstViewController.swift
//  KumuExam
//
//  Created by Macbook pro on 28/04/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import CoreData

class FirstViewController: BaseVC {
    
    //Reference to manage object context
    let context = (UIApplication.shared.delegate as! AppDelegate)
    .persistentContainer.viewContext
    
    //Data for the table/Properties
    var items:[MovieList]?
    var viewModel: FirstVM!
    var searchActive: Bool = false
    
    //MARK: - Outlets
    @IBOutlet var movieListTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FirstVM(view: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - API Call/Get JSON data
    func jsonParsing() {
        viewModel.getJSONData(items: items)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //Fetch data from core data
        viewModel?.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieList = self.items?[indexPath.row]
        let detailVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.items = movieList
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieListTableView.dequeueReusableCell(withIdentifier: "movie_list_cell", for: indexPath) as! MovieListTableViewCell
        //Set data to labels/img
        let movieList = self.items?[indexPath.row]
        cell.nameLabel.text = movieList?.movieTitle
        cell.priceLabel.text = "\(movieList?.price ?? 0.0)"
        cell.genreLabel.text = movieList?.genre
        let dateVisited = movieList?.dateVisited ?? ""
        if !dateVisited.isEmpty {
            cell.dateVisited.text = "date visited: \(movieList?.dateVisited ?? "")"
            cell.dateVisited.isHidden = false
        } else {
            cell.dateVisited.isHidden = true
        }
        
        let artwork = movieList?.artwork ?? ""
        let artworkString: String = artwork
        let url = URL(string: artworkString)
        let resource = ImageResource(downloadURL: url!)
        cell.artworkImg.kf.setImage(with: resource)
        
        let image = (movieList?.isFavourite)! ? UIImage(named: "ic_save_yellow") as UIImage? : UIImage(named: "ic_save_gray") as UIImage?
        cell.favoritesButton.setBackgroundImage(image, for: .normal)
        
        //Set Favourites
        cell.saveAction = { [weak self] in
            let fav = movieList?.isFavourite ?? false
            movieList?.isFavourite = fav ? false : true
            do {
                try self?.context.save()
            } catch {
                print("failed updating isFavourite")
            }
            self?.viewModel?.fetchData()
        }
        return cell
    }
}

extension FirstViewController:UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false
        searchBar.endEditing(true)
        viewModel?.fetchData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.endEditing(true)
        viewModel?.fetchData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.searchActive = false
        searchBar.showsCancelButton = false
        viewModel?.fetchData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty
        {
            searchBar.endEditing(true)
            searchBar.showsCancelButton = false
            self.searchActive = false
            viewModel?.fetchData()
        } else {
             searchBar.showsCancelButton = true
            self.searchActive = true
            
            // Search for movie title
            do {
                let request = MovieList.fetchRequest() as NSFetchRequest<MovieList>
                let pred = NSPredicate(format: "movieTitle CONTAINS[c] %@", searchText)
                request.predicate = pred
                self.items = try context.fetch(request)
            }
            catch {
                print("search failed")
            }
        }
        self.movieListTableView.reloadData()
    }
}

extension FirstViewController: FirstViewProtocol {
    func fetchData() {
        viewModel.fetchData()
    }
    func getJSONData(items: [MovieList]?) {
        self.jsonParsing()
    }
    
    func reloadTable(items: [MovieList]?) {
        self.items = items
        self.movieListTableView.reloadData()
    }
}
