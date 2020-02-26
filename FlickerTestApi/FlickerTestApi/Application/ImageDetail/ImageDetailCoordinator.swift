//
//  ImageDetailCoordinator.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import Swinject
import UIKit

protocol ImageDetailCoordPresenter: Coordinator {

}

protocol ImageDetailCoordNavigationPresenter: AnyObject {
    func removeViewController()
}

class ImageDetailCoordinator: ImageDetailCoordPresenter {
    weak var navigationController: UINavigationController?

    var childCoordinators: [Coordinator] = []

    var isCompleted: (() -> ())?

    var viewModel: ImageDetailViewModelPresenter?

    var container: Container {
        let con = Container()
        con.register(ImageDetailViewModelPresenter.self) { _ in ImageDetailViewModel() }
        con.register(ImageDetailViewControllerPresenter.self) {_ in ImageDetailViewController.instantiateFrom(appStoryboard: .Main) }

        return con
    }

    init(to navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let navTemp = self.navigationController,
            let viewControllerTemp = container.resolve(ImageDetailViewControllerPresenter.self),
            let viewModelTemp = container.resolve(ImageDetailViewModelPresenter.self) {
            self.viewModel = viewModelTemp
            self.viewModel?.delegate = self
            viewControllerTemp.viewModel = self.viewModel

            navTemp.pushViewController(viewControllerTemp, animated: true)
        }
    }
}

extension ImageDetailCoordinator: ImageDetailCoordNavigationPresenter {
    func removeViewController() {
        self.navigationController?.popViewController(animated: true)
        self.isCompleted!()
    }
}
