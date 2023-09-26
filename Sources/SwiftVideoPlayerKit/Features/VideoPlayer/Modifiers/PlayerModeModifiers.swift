//
//  PlayerModeModifiers.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 18/8/23.
//

import SwiftUI

// MARK: - View Extensions for Video Player Layout Modifiers

extension View {
    /// Modifies the view's layout for portrait orientation based on the specified conditions.
    ///
    /// - Parameters:
    ///   - isPortrait: A boolean that determines if the view should be modified for portrait orientation.
    ///   - videoPlayerSize: The desired size for the video player in portrait orientation.
    /// - Returns: A view with the specified modifications applied for portrait orientation.
    func portraitPlayer(isPortrait: Bool, videoPlayerSize: CGSize) -> some View {
        return self.if(isPortrait) { view in
            return self.modifier(PortraitPlayerModifier(videoPlayerSize: videoPlayerSize))
        }
    }
    
    /// Modifies the view's layout for landscape orientation based on the specified conditions.
    ///
    /// - Parameters:
    ///   - isLandscape: A boolean that determines if the view should be modified for landscape orientation.
    /// - Returns: A view with the specified modifications applied for landscape orientation.
    func landscapePlayer(isLandscape: Bool) -> some View {
        return self.if(isLandscape) { view in
            return self.modifier(LandscapePlayerModifier())
        }
    }
}

extension View {
    /// A conditional view modifier. If the condition is true, applies the transformation to the view.
    ///
    /// - Parameters:
    ///   - condition: The condition upon which the transformation is applied.
    ///   - transform: The transformation to apply to the view.
    /// - Returns: A view with the transformation applied if the condition is true, otherwise the unmodified view.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

// MARK: - Custom Video Player Layout Modifiers

/// A view modifier for adjusting the layout of the video player to fit a portrait orientation.
struct PortraitPlayerModifier: ViewModifier {
    let videoPlayerSize: CGSize

    /// Modifies the content view to fit the specified size.
    ///
    /// - Parameters:
    ///   - content: The content to be modified.
    /// - Returns: A view that fits the specified size.
    func body(content: Content) -> some View {
        content
            .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
    }
}

/// A view modifier for adjusting the layout of the video player to fit a landscape orientation.
struct LandscapePlayerModifier: ViewModifier {
    
    /// Modifies the content view to ignore safe area insets, providing a full screen landscape experience.
    ///
    /// - Parameters:
    ///   - content: The content to be modified.
    /// - Returns: A view that ignores safe area insets.
    func body(content: Content) -> some View {
        content
            .edgesIgnoringSafeArea(.all)
    }
}
