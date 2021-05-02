//
//  MovieListTableViewCell.swift
//  KumuExam
//
//  Created by Macbook pro on 28/04/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet var artworkImg: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var dateVisited: UILabel!
    @IBOutlet var favoritesButton: UIButton!
    
    var saveAction : (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Setup UI
    private func setupUI() {
        artworkImg.contentMode = .scaleAspectFit
        artworkImg.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        genreLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        priceLabel.font = UIFont.boldSystemFont(ofSize: 13.0)
        dateVisited.font = UIFont.boldSystemFont(ofSize: 11.0)
    }
    
    //MARK: - Add/remove to favourites
    @IBAction func saveAction(_ sender: Any) {
        saveAction?()
    }
}
