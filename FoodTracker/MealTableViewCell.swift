//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by 吴海豹 on 2019/5/26.
//  Copyright © 2019 吴海豹. All rights reserved.
//

import UIKit
import os.log

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
