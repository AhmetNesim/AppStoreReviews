//
//  Array.swift
//  AppStoreReviews
//
//  Created by AHMET OMER NESIM on 11.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

extension Array {
    func take(_ elementsCount: Int) -> [Element] {
        let min = Swift.min(elementsCount, count)
        return Array(self[0..<min])
    }
}

