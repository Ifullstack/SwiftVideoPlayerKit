//
//  SimpleVideoPlayerViewModel.swift
//
//
//  Created by Cane Allesta on 26/9/23.
//

import Foundation
import Observation
import AVKit

@Observable public class SimpleVideoPlayerViewModel {
    /// The player responsible for playing the video.
    var player: AVPlayer
    
    /// An error that might occur while using the video player.
    var videoError: VideoPlayerError?
    
    /// Initializes the view model with a given source.
    ///
    /// - Parameter source: The model containing video player data source.
    public init(source: PlayerSource) {
        do {
            self.player = try VideoPlayerViewHelper.createAVPlayer(from: source)
        } catch {
            // Use some url error
            self.player = AVPlayer()
            self.videoError = error as? VideoPlayerError
        }
    }
}
