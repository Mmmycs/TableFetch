//
//  FirstVM.swift
//  KumuExam
//
//  Created by Macbook pro on 02/05/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

protocol FirstViewProtocol {
    func reloadTable(items:[MovieList]?)
    func getJSONData(items: [MovieList]?)
    func fetchData()
}

class FirstVM {
    var mView: FirstViewProtocol!
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    var itemList:[MovieList]?
    
    init(view: FirstViewProtocol) {
        mView = view
    }
    
    //Load data from Core Data
    func fetchData() {
        do {
            self.itemList = try context.fetch(MovieList.fetchRequest())
            if itemList?.count == 0 {
                mView.getJSONData(items: self.itemList)
            }
            DispatchQueue.main.async { [weak self] in
                self?.mView.reloadTable(items: self?.itemList)
            }
        }
        catch {
            print("Failed fetching data ")
        }
    }
    
    // Get JSON data from API
    func getJSONData(items: [MovieList]?) {
        let url = URL(string: Server.APIURL)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do {
                
                let json = try JSON(data: data)
                let result = json["results"]
                let entity = NSEntityDescription.entity(forEntityName: "MovieList", in: self.context)!
                
                for array in result.arrayValue {
                    let data = NSManagedObject(entity: entity, insertInto: self.context)
                    // Set values to entity attributes
                    print("value data: \n \(array["trackName"]) \n \(array["artistName"]) \n \(array["primaryGenreName"]) \n \(array["artworkUrl100"]) \n \(array["longDescription"]) \n \(array["dateVisited"]) \n \(array["collectionPrice"]) \n ")
                    data.setValue("\(array["trackName"])", forKey: "movieTitle")
                    data.setValue("\(array["artistName"])", forKey: "artistName")
                    data.setValue("\(array["primaryGenreName"])", forKey: "genre")
                    data.setValue("\(array["artworkUrl100"])", forKey: "artwork")
                    data.setValue("\(array["longDescription"])", forKey: "desc")
                    data.setValue("", forKey: "dateVisited")
                    data.setValue(array["collectionPrice"].double ?? 0.0, forKey: "price")
                    
                    do {
                        try self.context.save()
                    } catch {
                        print("error saving data")
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    print("call dispatch reload table2a!")
                    self?.fetchData()
                }
            } catch {
                print("error value: \(error.localizedDescription)")
            }
        }.resume()
    }

}

