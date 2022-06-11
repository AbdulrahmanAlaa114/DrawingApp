//
//  photoTableViewCell.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//  Copyright © 2022 Ranosys. All rights reserved.
//

import UIKit

class photoTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var creationTime: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var redrawBtn: UIButton!
    
    var subscribeDeleteBtn: (() -> ())?
    var subscribeEditBtn: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configerCell(with data: PhotoData){
        photo.image = data.image
        name.text = data.name
        let format = DateFormatter()
        format.dateFormat = "HH:mm"
        creationTime.text = "Creation Time \(format.string(from: data.creatingDate))"
    }
    
    @IBAction func deleteButtonTapeed(_ sender : UIButton){
        subscribeDeleteBtn?()
        
    }
    
    @IBAction func redrawButtonTapeed(_ sender : UIButton){
        subscribeEditBtn?()
    }
    
}
