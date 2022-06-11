//
//  DataBaseManger.swift
//  DrawingApp
//
//  Created by Abdulrahman on 11/06/2022.
//

import Foundation

class DataBaseManger {
    
    static var shared = DataBaseManger()
    private init() {}
    
    var dataBase: DataBaseService = CoreDataManger()
    var cachedImages: CachedImageService = CachPhotoInFileManger()
}
