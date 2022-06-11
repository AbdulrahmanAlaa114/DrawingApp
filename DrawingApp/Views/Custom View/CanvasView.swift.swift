//
//  CanvasView.swift.swift
//  DrawingApp
//
//  Created by Abdulrahman on 09/06/2022.
//

import UIKit

class CanvasView: UIView {

    var lines = [Line]()
    var deletedLines = [Line]()
    var strokeWidth: CGFloat = 2.0
    var strokeColor: UIColor = .black
    var strokeOpacity: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        lines.forEach { (line) in
            for (i, p) in (line.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line(color: UIColor(), points: [CGPoint]()))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else { return }
        guard var lastPoint = lines.popLast() else { return }
        lastPoint.points?.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lastPoint.opacity = strokeOpacity
        lines.append(lastPoint)
        setNeedsDisplay()
    }
    
    func clearCanvasView() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undoDraw() {
        if lines.count > 0 {
            deletedLines.append(lines.removeLast())
            setNeedsDisplay()
        }
    }
    
    func deleteSpecifiedLineWith(index: Int){
        deletedLines.append(lines.remove(at: index))
        setNeedsDisplay()
    }
    
    func redoDraw() {
        if deletedLines.count > 0 {
            lines.append(deletedLines.removeLast())
            setNeedsDisplay()
        }
    }
    
}

struct Line {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]?) {
        self.color = color
        self.points = points
    }
}
