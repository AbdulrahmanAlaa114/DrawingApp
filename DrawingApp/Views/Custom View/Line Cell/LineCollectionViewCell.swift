//
//  LineCollectionViewCell.swift
//  DrawingApp
//
//  Created by Abdulrahman on 11/06/2022.
//

import UIKit

class LineCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(line: Line){
        
        canvasView.clearCanvasView()
        canvasView.lines = [line]
        canvasView.draw(CGRect())
        setNeedsDisplay()
        
    }
}
