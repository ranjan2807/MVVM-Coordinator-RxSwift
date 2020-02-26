//
//  ImageListCoordinator.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import RxSwift
import RxCocoa

protocol ImageListCoordPresenter: Coordinator {

}

protocol ImageListCoordNavigationPresenter: AnyObject {
    func didSelectImage(imgId: String?)
}

class ImageListCoordinator: ImageListCoordPresenter {
    var viewModel: ImageListViewModelPresenter?

    weak var navigationController: UINavigationController?

    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?

    var container: Container {
        let con = Container()
        con.register (ImageListViewControllerPresenter.self) { _ in
            ImageListViewController.instantiateFrom(appStoryboard: .Main)
        }
        con.register(ImageListViewModelPresenter.self) { _ in ImageListViewModel() }
        con.register(ImageDetailCoordPresenter.self) {
            _ in ImageDetailCoordinator(to: self.navigationController!)
            
        }

        return con
    }

    init(to navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        if let navControllerTemp = self.navigationController,
            let viewModelTemp = container.resolve(ImageListViewModelPresenter.self),
            let viewController = container.resolve(ImageListViewControllerPresenter.self) {

            self.viewModel = viewModelTemp
            self.viewModel?.delegate = self
            viewController.viewModel = self.viewModel

            self.viewModel?.photoId
                .subscribe(onNext: { (_) in
                    navControllerTemp.pushViewController(viewController, animated: true)
                })
        }
    }
}

extension ImageListCoordinator: ImageListCoordNavigationPresenter {
    func didSelectImage(imgId: String?) {
        if let coordinator = container.resolve(ImageDetailCoordPresenter.self) {
            self.update(coordinator: coordinator)
            coordinator.start()
        }
    }
}
