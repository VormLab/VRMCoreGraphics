import Foundation
import UIKit

public class VRMDottedCurveWithAShadow: UIView {
    
    public override func drawRect(rect: CGRect) {
        
        // Constants
        let margin = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        let pointA = CGPoint(x: rect.minX + margin.left, y: rect.midY)
        let pointB = CGPoint(x: rect.midX / 2, y: rect.minY + margin.top)
        let pointC = CGPoint(x: rect.midX, y: rect.midY)
        let pointD = CGPoint(x: 3 / 2 * rect.midX + margin.left, y: rect.maxY - margin.bottom)
        let pointE = CGPoint(x: rect.maxX - margin.right, y: rect.midY)
        let lineWidth = CGFloat(3.0)
        let shadowOffset = CGSize(width: -10, height: 15)
        
        // Draw dotted line with a shadow
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.grayColor().CGColor)
        CGContextSetShadow(context, shadowOffset, 5)
        
        CGContextMoveToPoint(context, pointA.x, pointA.y)
        CGContextAddQuadCurveToPoint(context, pointB.x, pointB.y, pointC.x, pointC.y)
        CGContextAddQuadCurveToPoint(context, pointD.x, pointD.y, pointE.x, pointE.y)
        
        let dashes: [CGFloat] = [lineWidth * 0, lineWidth * 2]
        CGContextSetLineDash(context, 0, dashes, dashes.count)
        
        CGContextSetLineCap(context, .Round)
        CGContextStrokePath(context)
    }
}
