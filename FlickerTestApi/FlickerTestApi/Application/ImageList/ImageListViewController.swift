//
//  ImageListViewController.swift
//  FlickerTestApi
//
//  Created by Newpage-iOS on 10/01/20.
//  Copyright © 2020 Ranjan-iOS. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol ImageListViewControllerPresenter: UIViewController {
    var viewModel: ImageListViewModelDataPresenter? { get set }
}

class ImageListViewController: UIViewController, ImageListViewControllerPresenter {

    weak var viewModel: ImageListViewModelDataPresenter?

    @IBOutlet weak var tblImages: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()

    /// Method that deinit ImageListViewController
    deinit {
        print("\(type(of: self)) dealloced ......")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindView()
        viewModel?.load(searchText: "A")
    }
}

extension ImageListViewController {

    func bindView() {
        if let viewModelTemp = viewModel {
            viewModelTemp.imageList.bind(to: self.tblImages
                .rx
                .items(cellIdentifier: "image-cell", cellType: ImageTableViewViewCell.self)) { row, element, cell in
                    cell.renderCell(title: element.title, image: URL(string: NetworkUrl.photoData(element).urlString()))
            }.disposed(by: disposeBag)

            self.tblImages
                .rx
                .modelSelected(ImageModel.self)
                .map{ $0 }
                .subscribe(onNext: { (element) in
                    viewModelTemp.navigateToDetail(photoId: element.photoId)
                }).disposed(by: disposeBag)

            viewModelTemp.isLoading
                .asObservable()
                .bind(to: self.activity
                .rx
                .isAnimating)
            .disposed(by: disposeBag)

        }
    }
}

