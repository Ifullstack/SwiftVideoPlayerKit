//
//  PlayerView.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 10/8/23.
//

import SwiftUI
import AVKit

struct PlayerView: UIViewRepresentable {
    // Properties
    let player: AVPlayer
    var orientation: UIDeviceOrientation

    // This function gets called whenever the SwiftUI view updates.
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<PlayerView>) {}
    
    // This function creates the actual UIView (or a subclass of it) that this SwiftUI view represents.
    func makeUIView(context: Context) -> UIView {
        saveOrientation()
        return PlayerUIView(frame: .zero,
                            player: player)
        
    }
    
    class PlayerUIView: UIView {
        // This is the actual player layer that will display the video content.
        private let playerLayer = AVPlayerLayer()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        init(frame: CGRect,
             player: AVPlayer) {
            super.init(frame: frame)
            // Setting the video gravity determines how the video is displayed within the layer's bounds.
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.player = player // Assign the AVPlayer
            self.layer.addSublayer(playerLayer) // Add the player layer to the view's main layer
        }
        
        // This gets called whenever the view's size changes.
        // Here, we make sure that the player layer always fills the entire bounds of the view.
        override func layoutSubviews() {
            super.layoutSubviews()
            playerLayer.frame = bounds
        }
    }
    
    // This function saves the current device orientation to UserDefaults.
    private func saveOrientation() {
        if orientation.isLandscape {
            UserDefaults.standard.setValue(true, forKey: "isFullScreen")
        }
        if orientation.isPortrait {
            UserDefaults.standard.setValue(false, forKey: "isFullScreen")
        }
    }
}



