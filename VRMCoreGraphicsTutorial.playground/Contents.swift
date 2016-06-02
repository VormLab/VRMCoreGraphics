import Foundation
import UIKit
import XCPlayground

// MARK: Constants

private struct Constants {
    static let WindowHeight = 568.0
    static let WindowWidth = 375.0
}

// MARK: Window configuration

let bounds = CGRect(x: 0.0, y: 0.0, width: 300, height: 300)
let window = UIView(frame: bounds)
window.backgroundColor = .lightGrayColor()

/* =========================================================================== */

// MARK: Drawing

/* 
 * Simple Examples
 * source: http://www.techotopia.com/index.php/An_iOS_8_Swift_Graphics_Tutorial_using_Core_Graphics_and_Core_Image
 *
 */

//let aView = VRMLineView(frame: window.frame)
//let aView = VRMDiamondView(frame: window.frame)
//let aView = VRMRectangleView(frame: window.frame)
//let aView = VRMElipseView(frame: window.frame)
//let aView = VRMArcView(frame: window.frame)
//let aView = VRMBezierCurveView(frame: window.frame)
//let aView = VRMDashedLineView(frame: window.frame)
//let aView = VRMShadowView(frame: window.frame)
//let aView = VRMGradientView(frame: window.frame)

/*
 * Complex examples
 */

// 1. Dotted Curve with a shadow
//let aView = VRMDottedCurveWithAShadow(frame: window.frame)

// 2. Gradient Donut
//let aView = VRMGradientDonut(frame: window.frame)

// 3. Gradient Graph
let graphFrame = CGRect(origin: window.frame.origin, size: CGSize(width: window.frame.width - 60.0, height: window.frame.width - 30.0))
let graphView = VRMGradientGraphView(frame: graphFrame)
graphView.layer.cornerRadius = 16.0
graphView.layer.masksToBounds = true
graphView.layer.borderWidth = 3.0
graphView.layer.borderColor = UIColor.whiteColor().CGColor
graphView.backgroundColor = .darkGrayColor()
let aView = UIView(frame: window.frame)
aView.addSubview(graphView)
graphView.center = aView.center

aView.backgroundColor = .clearColor()
window.addSubview(aView)

/* =========================================================================== */

// MARK: XCPlaygroundPage

XCPlaygroundPage.currentPage.liveView = window
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

