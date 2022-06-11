//
//  DataBaseService.swift.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import Foundation

protocol DataBaseService {
    
    func savePhotoWith(data: PhotoData)
    func fetchPhotos() -> [Photo]
    func deletePhotoWith(id: String)
    
}
