import Foundation
import UIKit

public class VRMDiamondView: UIView {
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        CGContextMoveToPoint(context, 100, 100)
        CGContextAddLineToPoint(context, 150, 150)
        CGContextAddLineToPoint(context, 100, 200)
        CGContextAddLineToPoint(context, 50, 150)
        CGContextAddLineToPoint(context, 100, 100)
        CGContextStrokePath(context)
    }
}
