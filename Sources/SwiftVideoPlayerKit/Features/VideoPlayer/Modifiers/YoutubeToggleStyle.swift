//
//  YoutubeToggleStyle.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 21/8/23.
//

import SwiftUI

/// A custom `ToggleStyle` that emulates the appearance of a YouTube-themed toggle switch.
///
/// This style modifies the appearance of the toggle to resemble a switch with play and pause icons from YouTube.
/// It allows for the on and off states to have distinct colors, and the thumb is customized to display system images
/// for play and pause based on the toggle's state.
struct YoutubeToggleStyle: ToggleStyle {
    
    /// The color of the toggle when it's in the "on" state.
    var onColor = Color(Color.init(uiColor: UIColor(red: 0.699, green: 0.699, blue: 0.699, alpha: 1)))
    /// The color of the toggle when it's in the "off" state.
    var offColor = Color(UIColor.gray)
    /// The color of the thumb (play/pause icon) inside the toggle.
    var thumbColor = Color.white
    
    /// Produces a view representing the body of a toggle.
    ///
    /// This method defines the appearance and behavior of the toggle. The toggle has rounded corners and uses
    /// system images to represent the play and pause states. The play image appears when the toggle is on, and
    /// the pause image appears when the toggle is off.
    ///
    /// - Parameters:
    ///   - configuration: The properties of the toggle.
    /// - Returns: A view that displays the toggle in the custom style.
    func makeBody(configuration: Self.Configuration) -> some View {
        Button(action: { configuration.isOn.toggle() } )
        {
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 44, height: 18)
                .overlay(
                    Image(systemName: configuration.isOn ? "play.circle.fill" : "pause.circle.fill")
                        .foregroundColor(thumbColor)
                        .font(.system(size: 24))
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? 10 : -10)
                )
                .animation(Animation.easeInOut(duration: 0.1), value: configuration.isOn)
        }
        .font(.title)
        .padding(.horizontal)
    }
}
