import Foundation
import UIKit

public class VRMArcView: UIView {
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        CGContextMoveToPoint(context, 100, 100)
        CGContextAddArcToPoint(context, 100,200, 300,200, 100)
        CGContextStrokePath(context)
    }
}