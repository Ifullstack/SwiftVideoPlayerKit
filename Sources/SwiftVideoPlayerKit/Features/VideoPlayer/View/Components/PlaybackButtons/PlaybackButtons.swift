//
//  PlaybackButtons.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 19/8/23.
//

import SwiftUI

/// A button view with a default playback design.
///
/// This struct provides a common design for a playback button that is circular
/// with an SF Symbol icon in the center. The button action and the system icon
/// name are provided as parameters.
struct DefaultPlaybackButton: View {
    /// The name of the system icon to display.
    var systemName: String
    
    /// The action to execute when the button is tapped.
    var action: () -> Void
    
    /// The body property to describe the button's view layout
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.title3)
                .fontWeight(.ultraLight)
                .foregroundColor(.white)
                .padding(12)
                .background(Circle().fill(Color.black.opacity(0.35)))
        }
    }
}

/// A specialized playback button for play and pause actions.
///
/// This struct provides a design that is similar to `DefaultPlaybackButton` but
/// is slightly larger and doesn't come with an action since it's typically used
/// as a display view.
struct PlayPausePlaybackButton: View {
    /// The name of the system icon to display.
    var systemName: String

    /// The body property to describe the button's view layout.
    var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .fontWeight(.ultraLight)
            .foregroundColor(.white)
            .padding(16)
            .background(Circle().fill(Color.black.opacity(0.35)))
    }
}

/// A button view designed for seeking actions like forward or rewind.
///
/// This struct provides a minimalist design where the icon stands out
/// without a background, typically used for seeking actions in a playback UI.
struct SeekPlaybackButton: View {
    /// The name of the system icon to display.
    var systemName: String
    
    /// The body property to describe the button's view layout.
    var body: some View {
        Image(systemName: systemName)
            .font(.title2)
            .fontWeight(.ultraLight)
            .foregroundColor(.white)
            .padding(12)
    }
}

/// A button designed for the rotation action in a video player UI.
///
/// The design uses a custom image for the rotation action and is framed
/// to a specific size. It's also padded for optimal touch target size.
struct RotatePlaybackButton: View {
    /// The name of the image asset to display.
    var name: String
    
    /// The action to execute when the button is tapped.
    var action: () -> Void

    /// The body property to describe the button's view layout.
    var body: some View {
        Button(action: action) {
            Image(name)
                .resizable()
                .frame(width: 14, height: 14)
                .padding(15)
                
        }
    }
}
