//
//  RotationAngleHelper.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 17/8/23.
//

import UIKit
import SwiftUI

/// A helper class providing utility methods related to rotation angles for various device orientations.
class RotationAngleHelper {
    /// Determines the rotation angle (in radians) for a given device orientation.
    ///
    /// - Parameter orientation: The current orientation of the device.
    /// - Returns: A rotation angle in radians for the provided device orientation.
    static func rotationAngle(for orientation: UIDeviceOrientation) -> CGFloat {
        switch orientation {
            case .portrait:
                return 0.0
            case .portraitUpsideDown:
                return CGFloat.pi
            case .landscapeLeft:
                return CGFloat.pi / 2
            case .landscapeRight:
                return -CGFloat.pi / 2
            default:
                return 0.0
        }
    }
    
    /// Determines the rotation angle (in degrees) for a given device orientation.
    ///
    /// - Parameter orientation: The current orientation of the device.
    /// - Returns: An `Angle` object representing the rotation angle in degrees for the provided device orientation.
    static func rotationAngle(for orientation: UIDeviceOrientation) -> Angle {
        return Angle(degrees: RotationAngleHelper.rotationAngle(for: orientation))
    }
}
