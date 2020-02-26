//
//  HikeDataManager.swift
//  HikeTest
//
//  Created by Newpage-iOS on 28/09/19.
//  Copyright © 2019 Ranjan-iOS. All rights reserved.
//

import Foundation

class NetworkDataManager
{
    func fetchPhoto(search:String,
                    page:Int,
                    completion:@escaping (Bool, ImageListData?)->())
    {
        let urlStr = NetworkUrl.photoList(search, page).urlString()
        
        let url = URL(string: urlStr)
        
        let session = URLSession.shared
        NetworkDataManager.stopAllRequest()
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                completion(false, nil)
            } else {
                if let dataTemp = data {
                    let photosResponse = try! JSONDecoder().decode(ImageResponse.self, from: dataTemp)
                    
                    if photosResponse.stat == "ok" {
                        completion(true, photosResponse.photos!)
                    } else {
                        completion(false, nil)
                    }
                    
                } else {
                    completion(false, nil)
                }
            }
        }
        
        task.resume()
    }
    
    static func stopAllRequest()
    {
        URLSession.shared.finishTasksAndInvalidate()
    }
}
