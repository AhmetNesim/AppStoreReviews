//
//  File.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 11.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation


class Service {
    
    let networking = Networking()
    
    func getReviews(completion: @escaping (Reviews?) -> ()) {
        
        networking.performRequest(type: Reviews.self, endpoint: AppStoreAPI.reviews(language: .Dutch)) { response in
            switch response {
            case let .success(items):
                completion(items)
            case let .failure(error):
                print(error)
                completion(nil)
            }
            
        }
    }
}
