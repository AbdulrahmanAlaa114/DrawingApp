//
//  PhotoModels.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

struct PhotoData {
    let name: String
    let id: String
    let creatingDate: Date
    let image: UIImage
}

struct SectionedPhoto {
    let creatingDate: String
    var photos: [PhotoData]
}
