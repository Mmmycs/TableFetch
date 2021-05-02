//
//  FavouritesTableViewCell.swift
//  KumuExam
//
//  Created by Macbook pro on 30/04/2021.
//  Copyright © 2021 Macbook pro. All rights reserved.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {
    //MARK:- Outlet
    @IBOutlet var artworkImg: UIImageView!
    @IBOutlet var movieTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: - Setup UI
    private func setupUI() {
        artworkImg.contentMode = .scaleAspectFit
        artworkImg.clipsToBounds = true
        movieTitleLbl.font = UIFont.boldSystemFont(ofSize: 13.0)
    }
}
