import Foundation
import UIKit

public class VRMElipseView: UIView {
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        let rectangle = CGRectMake(60,170,200,80)
        CGContextAddEllipseInRect(context, rectangle)
        CGContextStrokePath(context)
    }
}
