//
//  ImageDetailViewController.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import UIKit

protocol ImageDetailViewControllerPresenter: UIViewController {
    var viewModel: ImageDetailViewModelDataPresenter? { get set }
}

class ImageDetailViewController: UIViewController, ImageDetailViewControllerPresenter {

    weak var viewModel: ImageDetailViewModelDataPresenter?

    /// Method that deinit ImageDetailViewController
    deinit {
        print("\(type(of: self)) dealloced ......")
    }

    @IBAction func btnBack_onClick(_ sender: Any) {
        if let viewModelTemp = self.viewModel {
            viewModelTemp.didTappedBack()
        }
    }
}

