//
//  EndpointType.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

protocol EndpointType {

    var baseURL: URL { get }

    var path: String { get }

}
