//
// Created by 吴海豹 on 2019-05-25.
// Copyright (c) 2019 吴海豹. All rights reserved.
//

import UIKit

class Meal {

    var name: String

    var photo: UIImage?

    var rating: Int

    init?(name: String, photo: UIImage?, rating: Int) {

        guard !name.isEmpty && rating >= 0 && rating <= 5 else {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
}
