//
//  ImageListViewModel.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa

protocol ImageListViewModelDataPresenter: AnyObject {
    func load(searchText: String?)
    func navigateToDetail(photoId: String?)
    var imageList: BehaviorRelay<[ImageModel]> { get set }
    var isLoading: BehaviorRelay<Bool> { get set }
}

protocol ImageListViewModelPresenter: ImageListViewModelDataPresenter {
    var delegate: ImageListCoordNavigationPresenter? { get set }
    var photoId: BehaviorRelay<String?> { get set }
}

class ImageListViewModel {

    weak var delegate: ImageListCoordNavigationPresenter?

    var container: Container {
        let con = Container()
        con.register(ImageListWorkerPresenter.self) { _ in
            ImageListWorker()
        }
        return con
    }

    var worker: ImageListWorkerPresenter {
        return container.resolve(ImageListWorkerPresenter.self)!
    }

    var imageList: BehaviorRelay<[ImageModel]> = BehaviorRelay(value: [])
    var isLoading: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    var photoId: BehaviorRelay<String?> = BehaviorRelay(value: nil)
}

extension ImageListViewModel: ImageListViewModelPresenter {

    func load(searchText: String?) {
        self.isLoading.accept(true)
        worker.startLoadingImages(searchText: searchText) { (status, data) in
            if let list = data?.photo {
                DispatchQueue.main.async {
                    self.imageList.accept(list)
                    self.isLoading.accept(false)
                }
            }
        }
    }

    func navigateToDetail(photoId: String?) {
        if let photoIdTemp = photoId {
            self.photoId.accept(photoIdTemp)
        }
    }
}
