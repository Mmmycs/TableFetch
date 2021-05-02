//
//  DetailViewController.swift
//  KumuExam
//
//  Created by Macbook pro on 28/04/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var artworkImg: UIImageView!
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    //MARK: - Properties
    var items: MovieList?
    var viewModel: DetailVM!
    var indexPath: Int = 0
    let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup UI
        setUpData()
        viewModel = DetailVM(view: self)
        //Add date visited
        viewModel.addDateVisited(items: items)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Setup UI
    private func setUpData() {
        titleLabel.text = items?.movieTitle
        let artwork: String = items?.artwork ?? ""
        let url = URL(string: artwork)
        artworkImg.kf.setImage(with: url)
        artworkImg.contentMode = .scaleAspectFit
        artworkImg.clipsToBounds = true
        artistNameLabel.text = items?.artistName
        descLabel.text = items?.desc
    }
}

extension DetailViewController: DetailViewProtocol {
    
}
    

