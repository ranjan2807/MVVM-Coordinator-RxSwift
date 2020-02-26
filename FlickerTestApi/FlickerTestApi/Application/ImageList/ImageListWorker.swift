//
//  ImageListWorker.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation

protocol ImageListWorkerPresenter {
    func startLoadingImages (searchText: String?, completionBlock: @escaping (Bool, ImageListData?)->())
}

class ImageListWorker: ImageListWorkerPresenter {

    func startLoadingImages(searchText: String?, completionBlock: @escaping (Bool, ImageListData?) -> ()) {
        let manager = NetworkDataManager()
        manager.fetchPhoto(search: searchText!, page: 1) { (status, data) in
            completionBlock(status, data)
        }
    }
}
