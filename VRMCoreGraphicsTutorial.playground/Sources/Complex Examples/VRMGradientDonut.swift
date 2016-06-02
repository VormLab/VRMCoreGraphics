import Foundation
import UIKit

private enum CGMethod {
    case WindingCount, EvenOdd, ClippingPath
}
private let gradientPresent = false

// Set the variable to change CoreGraphics method
private let activeMethod = CGMethod.WindingCount

public class VRMGradientDonut: UIView {
    
    public override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 4.0)
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.blueColor().CGColor)
        
        if gradientPresent {
            CGContextSetFillColorWithColor(context,
                                           UIColor.clearColor().CGColor)
            drawGradientOvalInContext(context!, rect: rect)
        } else {
            CGContextSetFillColorWithColor(context,
                                           UIColor.yellowColor().CGColor)
            let arcCenter = CGPoint(x: rect.midX, y: rect.midY)
            let radius = rect.size.width / 2 - 20.0
            let startAngle = CGFloat(0)
            let endAngle = CGFloat(2 * M_PI)
            
            switch activeMethod {
            case .WindingCount:
                /* Add two circles using Winding Count Fill Rule
                 *
                 * Winding Count Fill Rule:
                 * 1. CoreGraphics draws every horizontal row within the path's bounding rectangle from left-to-right
                 * 2. At the start of each row, CoreGraphics sets the winding count for the shape to zero.
                 * 3. If CoreGraphics crosses a line in the shape at any point during the row, it notes if the line was going upwards or downwards at the point where CoreGraphics crossed it.
                 * 4. An upward line increases the winding count of the shape by 1.
                 * 5. A downward line decreases the winding count of the shape by 1.
                 * 6. If the winding count for the shape is ever non-zero (positive or negative) then pixels are filled according to the color of the shape.
                 *
                 *
                 * So when we draw one circle clockwise and another one counter-clockwise we will get desired shape - a circle with a hole inside
                 *
                 */
                
                CGContextAddArc(context, arcCenter.x, arcCenter.y, radius, startAngle, endAngle, 1)
                CGContextClosePath(context)
                CGContextMoveToPoint(context, rect.midX + radius / 2, rect.midY)
                CGContextAddArc(context, arcCenter.x, arcCenter.y, radius / 2, startAngle, endAngle, 0)
                CGContextClosePath(context)
                
                CGContextDrawPath(context, .FillStroke)
                
            case .EvenOdd:
                /* We could get the same effect by using even odd rule.
                 * Drawing direction doesn't matter at all in this situation.
                 */
                CGContextAddArc(context, arcCenter.x, arcCenter.y, radius, startAngle, endAngle, 0)
                CGContextClosePath(context)
                CGContextMoveToPoint(context, rect.midX + radius / 2, rect.midY)
                CGContextAddArc(context, arcCenter.x, arcCenter.y, radius / 2, startAngle, endAngle, 0)
                CGContextClosePath(context)
                CGContextDrawPath(context, .EOFillStroke)
                
            case .ClippingPath:
                /* We could also create a clipping path to mask a part of drawing area.
                 */
                CGContextSaveGState(context)
                CGContextAddRect(context, CGContextGetClipBoundingBox(context))
                
                // create clipping path
                CGContextAddArc(context, arcCenter.x, arcCenter.y, radius / 2, startAngle, endAngle, 0)
                CGContextClosePath(context)
                CGContextEOClip(context)
                
                // create oval to fill
                CGContextMoveToPoint(context, rect.midX + radius, rect.midY)
                CGContextAddArc(context, arcCenter.x, arcCenter.y, radius, startAngle, endAngle, 0)
                CGContextClosePath(context)
                
                CGContextDrawPath(context, .FillStroke)
            }
        }
    }
    
    private func drawLinearGradientInContext(context: CGContext, rect: CGRect) {
        
        let colors = [UIColor.blueColor().CGColor, UIColor.greenColor().CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        let startPoint = CGPointZero
        let endPoint = CGPoint(x:0, y: rect.height)
        
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    .DrawsAfterEndLocation)

    }
    
    private func drawGradientOvalInContext(context: CGContext, rect: CGRect) {
        let arcCenter = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.size.width / 2 - 20.0
        let startAngle = CGFloat(0)
        let endAngle = CGFloat(2 * M_PI)
        
        CGContextSaveGState(context)
        CGContextAddArc(context, arcCenter.x, arcCenter.y, radius, startAngle, endAngle, 1)
        CGContextClosePath(context)
        CGContextAddArc(context, arcCenter.x, arcCenter.y, radius / 2, startAngle, endAngle, 0)
        CGContextClosePath(context)
        CGContextEOClip(context)
        
        drawLinearGradientInContext(context, rect: rect)
        
        CGContextRestoreGState(context);
    }
}
