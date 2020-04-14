//
//  CollectionEx.swift
//  iOSUtil
//
//  Created by 1002659 on 14/04/2020.
//  Copyright © 2020 wooky. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
