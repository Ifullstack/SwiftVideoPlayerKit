//
//  RotationModifier.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 26/8/23.
//

import SwiftUI

// MARK: - Device Rotation View Modifier

/// A view modifier that performs an action when the device's orientation changes.
///
/// The `DeviceRotationViewModifier` listens for `UIDevice.orientationDidChangeNotification`
/// and performs the provided action when the orientation changes.
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    /// Modifies the view to perform the given action when the device's orientation changes.
    ///
    /// - Parameters:
    ///   - content: The original view that is being modified.
    /// - Returns: A modified view that performs the action on orientation change.
    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// MARK: - View Extension for Device Rotation
extension View {
    
    /// Applies the `DeviceRotationViewModifier` to the view, allowing it to perform an action
    /// when the device's orientation changes.
    ///
    /// - Parameters:
    ///   - action: The action to be performed when the orientation changes.
    /// - Returns: A view modified to perform the given action on orientation change.
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
