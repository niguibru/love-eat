//
//  EnvironmentValues+ImageCache.swift
//  LoveEat (iOS)
//
//  Created by Nicolas Brucchieri on 22/04/2021.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
