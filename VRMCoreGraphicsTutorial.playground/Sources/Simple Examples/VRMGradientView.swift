import Foundation
import UIKit

public class VRMGradientView: UIView {
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let locations: [CGFloat] = [ 0.0, 0.25, 0.5, 0.75 ]
        let colors = [UIColor.redColor().CGColor,
                      UIColor.greenColor().CGColor,
                      UIColor.blueColor().CGColor,
                      UIColor.yellowColor().CGColor]
        let colorspace = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradientCreateWithColors(colorspace, colors, locations)
        var startPoint = CGPoint()
        var endPoint =  CGPoint()
        startPoint.x = 0.0
        startPoint.y = 0.0
        endPoint.x = 600
        endPoint.y = 600
        CGContextDrawLinearGradient(context, gradient,
                                    startPoint, endPoint, .DrawsAfterEndLocation)
    }
}
