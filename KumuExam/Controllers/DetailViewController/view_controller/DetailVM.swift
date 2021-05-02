//
//  DetailVM.swift
//  KumuExam
//
//  Created by Macbook pro on 02/05/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewProtocol {
    
}

class DetailVM {
    var mView: DetailViewProtocol!
    var items: MovieList?
    var indexPath: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init(view: DetailViewProtocol) {
        mView = view
    }
    
    func addDateVisited(items: MovieList?) {
        let date = Date()
        items?.dateVisited = date.toHumanReadableFormat()
        do {
            try self.context.save()
        } catch {
            print("failed updating isFavourite")
        }
    }
}
