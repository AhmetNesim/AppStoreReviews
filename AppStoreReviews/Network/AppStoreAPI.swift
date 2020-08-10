//
//  AppStoreAPI.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

enum AppStoreAPI {
    case reviews(language: Language)
}

enum Language : String {
    case Dutch = "nl"
    case Turkish = "tr"
}

extension AppStoreAPI: EndpointType {
    var baseURL: URL {
        return URL(string: "https://itunes.apple.com")!
    }

    var path: String {
        switch self {
        case .reviews(let language):
            return "/\(language.rawValue)/rss/customerreviews/id=474495017/sortby=mostrecent/json"
        }
    }
}
