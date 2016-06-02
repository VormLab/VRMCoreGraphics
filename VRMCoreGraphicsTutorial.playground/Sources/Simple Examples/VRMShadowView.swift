import Foundation
import UIKit

public class VRMShadowView: UIView {
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let myShadowOffset = CGSizeMake (-10,  15)
        
        CGContextSaveGState(context)
        
        CGContextSetShadow (context, myShadowOffset, 5)
        
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        let rectangle = CGRectMake(60,170,200,80)
        CGContextAddEllipseInRect(context, rectangle)
        CGContextStrokePath(context)
        CGContextRestoreGState(context)
    }
}
