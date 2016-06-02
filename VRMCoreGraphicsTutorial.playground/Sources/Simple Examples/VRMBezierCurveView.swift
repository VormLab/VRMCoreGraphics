import Foundation
import UIKit

public class VRMBezierCurveView: UIView {
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        CGContextMoveToPoint(context, 10, 200)
        CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200)
        CGContextStrokePath(context)
    }
}
