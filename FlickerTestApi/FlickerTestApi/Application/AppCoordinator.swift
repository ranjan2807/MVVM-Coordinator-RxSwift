//
//  AppCoordinator.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 16/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    var childCoordinators : [Coordinator] { get set }
    var isCompleted: (() -> ())? { get set }

    func start()
}


extension Coordinator {

    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func update(coordinator: Coordinator) {
        self.store(coordinator: coordinator)
        coordinator.isCompleted = { [weak self] in
            self!.free(coordinator: coordinator)
        }
    }
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController?

    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> ())?
    var window: UIWindow

    var container: Container {
        let con = Container()
        con.register(ImageListCoordPresenter.self) { _ in
            ImageListCoordinator(to: self.navigationController!)
        }
        return con
    }

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }

    func start() {
        if let coordinator = container.resolve(ImageListCoordPresenter.self) {
            self.update(coordinator: coordinator)
            coordinator.start()
        }

        self.window.rootViewController = navigationController
    }

}


