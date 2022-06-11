//
//  CachedImageService.swift
//  DrawingApp
//
//  Created by Abdulrahman on 11/06/2022.
//

import UIKit

protocol CachedImageService {
    
    func saveImageWith(fileName: String, image: UIImage)
    
    func removeImageWith(fileName: String)
    
    func loadImageWith(fileName: String) -> UIImage?
    
}
