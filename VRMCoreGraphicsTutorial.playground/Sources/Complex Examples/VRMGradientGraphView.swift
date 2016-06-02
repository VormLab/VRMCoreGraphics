import Foundation
import UIKit

public class VRMGradientGraphView: UIView {
    
    var points : [CGPoint]!
    var path: UIBezierPath!
    
    override public func drawRect(rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set colors within current context
        CGContextSetStrokeColorWithColor(context,
                                         UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(context, 3.0)
        CGContextSetFillColorWithColor(context,
                                       UIColor.yellowColor().CGColor)
        
        points = produceRandomPointsWithinRect(rect, numOfPoints: 10)
        path = graphBezierPathInContext(context, andRect: rect)
        
        // Draw gradient under the graph
        drawGradientInContext(context, fromPoints: points, path: path, rect: rect)
        
        // Draw a graph
        drawGraphInContext(context, andRect: rect)
        
    }
    
    private func graphBezierPathInContext(context: CGContext, andRect rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(points[0])
        for i in 1..<points.count {
            let currentPoint = points[i]
            path.addLineToPoint(currentPoint)
        }
        return path
    }
    
    private func drawGraphInContext(context: CGContext, andRect rect: CGRect) {
        
        CGContextSaveGState(context)

        CGContextSetStrokeColorWithColor(context, UIColor.yellowColor().CGColor)
        CGContextAddPath(context, path.CGPath)
        CGContextStrokePath(context)
        
        CGContextRestoreGState(context)
    }
    
    private func produceRandomPointsWithinRect(rect: CGRect, numOfPoints: Int) -> [CGPoint] {
        var points = [CGPoint]()
        let xOffset: CGFloat = 30.0
        let pointOffset = (rect.size.width - 2 * xOffset) / (CGFloat(numOfPoints) - 1)
        
        for i in 0..<numOfPoints {
            let newX = xOffset + CGFloat(i) * pointOffset
            let newY = rect.midY + CGFloat(arc4random_uniform(100)) - 50.0
            let newPoint = CGPoint(x: newX, y: newY)
            points.append(newPoint)
        }
        return points
    }
    
    private func drawGradientInContext(context: CGContext, fromPoints points: [CGPoint], path: UIBezierPath, rect: CGRect) {
        let height = rect.height
        let startPoint = CGPoint(x: points.last!.x, y: height)
        let endPoint = CGPoint(x: points.first!.x, y: height)
        
        defer {
            CGContextRestoreGState(context)
        }
        
        CGContextSaveGState(context)
        
        let fullGraphPath = UIBezierPath(CGPath: path.CGPath)
        fullGraphPath.addLineToPoint(startPoint)
        fullGraphPath.addLineToPoint(endPoint)
        fullGraphPath.closePath()
        fullGraphPath.addClip()
        
        let highestYPoint = points.maxElement { (pointA, pointB) -> Bool in
            return pointA.y >= pointB.y
        }
        guard let highestPoint = highestYPoint else { return }
        
        let gStartPoint = CGPoint(x:rect.midX, y: highestPoint.y)
        let gEndPoint = CGPoint(x:rect.midX, y:rect.height)
        let colors = [UIColor.whiteColor().CGColor, UIColor.clearColor().CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        
        CGContextDrawLinearGradient(context, gradient, gStartPoint, gEndPoint, .DrawsAfterEndLocation)
    }
}
