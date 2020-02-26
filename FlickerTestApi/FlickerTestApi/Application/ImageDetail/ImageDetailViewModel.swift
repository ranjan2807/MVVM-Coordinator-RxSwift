//
//  ImageDetailViewModel.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation

protocol ImageDetailViewModelDataPresenter: AnyObject {
    func load()
    func didTappedBack()
}

protocol ImageDetailViewModelPresenter: ImageDetailViewModelDataPresenter {
    var delegate: ImageDetailCoordNavigationPresenter? { get set }
}

class ImageDetailViewModel {
    weak var delegate: ImageDetailCoordNavigationPresenter?
}

extension ImageDetailViewModel: ImageDetailViewModelPresenter {

    func didTappedBack() {
        if let delegateTemp = self.delegate {
            delegateTemp.removeViewController()
        }
    }

    func load() {

    }
}
