//
//  ImageTableViewCell.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 17/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol ImageTableViewCellPresenter: UITableViewCell {
    func renderCell(title: String?, image: URL?)
}

class ImageTableViewViewCell: UITableViewCell, ImageTableViewCellPresenter {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!

    func renderCell(title: String?, image: URL?) {
        lbl.text = title
        img.sd_setImage(with: image, completed: nil)
    }
}
