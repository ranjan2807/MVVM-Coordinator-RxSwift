//
//  ImageModel.swift
//  HikeTest
//
//  Created by Newpage-iOS on 28/09/19.
//  Copyright © 2019 Ranjan-iOS. All rights reserved.
//

import Foundation


//"page":1,
//"pages":3994,
//"perpage":100,
//"total":"399343",
//"photo":

struct ImageResponse: Codable {
    var photos: ImageListData?
    var stat: String?
}

struct ImageListData: Codable {
    var page: Int?
    var pages: Int?
    var perpage: Int?
    var total: String?
    var photo: [ImageModel]?
    var searchText: String?
}


//"id":"48807018943",
//"owner":"28493949@N02",
//"secret":"d69f266f04",
//"server":"65535",
//"farm":66,
//"title":"2019.09.10 White climbing rose",
//"ispublic":1,
//"isfriend":0,
//"isfamily":0


struct ImageModel: Codable {
    var photoId: String?
    var title: String?
    var farm: Int?
    var server: String?
    var secret: String?
    
    private enum CodingKeys : String, CodingKey {
        case photoId = "id"
        case title, farm, server, secret
    }
}
