//
//  HikeUrl.swift
//  HikeTest
//
//  Created by Newpage-iOS on 28/09/19.
//  Copyright © 2019 Ranjan-iOS. All rights reserved.
//

import Foundation


enum NetworkUrl
{
    case photoList(String, Int)
    case photoData(ImageModel)
    
    func urlString () -> String
    {
        switch self {
        case .photoList(let searchText, let pageNumber):
            let str = App.Urls.PHOTO_LIST_URL + "&text=" + searchText + "&page=" + String(pageNumber)
            return str.replacingOccurrences(of: " ", with: "%20")
        case .photoData(let model):
            let str = "https://farm" + String(model.farm!) + ".static.flickr.com/" + model.server! + "/" + model.photoId! + "_" + model.secret! + ".jpg"
            return str.replacingOccurrences(of: " ", with: "%20")
        }
    }
}
