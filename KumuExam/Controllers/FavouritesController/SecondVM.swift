//
//  SecondVM.swift
//  KumuExam
//
//  Created by Macbook pro on 02/05/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

protocol SecondViewProtocol {
    func reloadTable(items:[MovieList]?)
}

class SecondVM {
    var mView: SecondViewProtocol!
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    var itemList:[MovieList]?
    
    init(view: SecondViewProtocol) {
        mView = view
    }
    
    //Load Data from Core Data
    func fetchData() {
        do {
            self.itemList = try context.fetch(MovieList.fetchRequest())
            DispatchQueue.main.async { [weak self] in
                self?.mView.reloadTable(items: self?.itemList)
            }
        }
        catch {
            print("Failed fetching data ")
        }
    }
}
