//
//  VideoPlayerViewModel.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 16/8/23.
//

import Foundation
import Observation
import SwiftUI
import AVKit

/// A view model that handles the logic and state management for the video player.
@Observable public class VideoPlayerViewModel {
    
    /// The player responsible for playing the video.
    var player: AVPlayer
    
    /// The data model for the video player.
    var model: VideoPlayerModel
    
    /// An error that might occur while using the video player.
    var videoError: VideoPlayerError?
    
    // MARK: - Video Player Properties
    var isShowingPlayerControls: Bool  = false
    var isPlaying: Bool  = false
    var timeoutTask: DispatchWorkItem?
    var isFinishedPlaying: Bool  = false
    var isSeeking: Bool  = false
    var progress: CGFloat = 0
    var lastDraggedProgress: CGFloat  = 0
    var isForcingFullScreen: Bool = false
    var currentDuration: Double = 0.0
    var totalDuration: Double = 0.0
    
    /// Initializes the view model with a given model.
    ///
    /// - Parameter model: The model containing video player data.
    public init(model: VideoPlayerModel) {
        do {
            self.player = try VideoPlayerViewHelper.createAVPlayer(from: model.source)
            self.model = model
        } catch {
            // Use some url error
            self.player = AVPlayer()
            self.model = VideoPlayerModel()
            self.videoError = error as? VideoPlayerError
        }
    }
}

// MARK: - Time Managment
extension VideoPlayerViewModel {
    /// Updates video time and progress based on the current and total durations.
    ///
    /// - Parameters:
    ///   - totalDuration: The total duration of the video.
    ///   - currentDuration: The current duration of the video playback.
    func updateVideoTimeAndProgress(from totalDuration: Double, currentDuration: Double) {
        let calculatedProgress: Double = currentDuration / totalDuration
        
        self.currentDuration = currentDuration
        self.totalDuration = totalDuration
        
        if !isSeeking {
            progress = CGFloat(calculatedProgress)
            lastDraggedProgress = progress
        }
        if calculatedProgress == 1 {
            isFinishedPlaying = true
            isPlaying = false
        }
    }
}

// MARK: - Landscape Management
extension VideoPlayerViewModel {
    /// Determines if the current orientation represents a landscape mode.
    ///
    /// - Parameter orientation: The current orientation of the device.
    /// - Returns: A boolean value indicating if the orientation is landscape mode.
    func isLandscapeMode(orientation: UIDeviceOrientation) -> Bool {
        if orientation.isValidInterfaceOrientation {
            if orientation.isLandscape {
                return true
            } else {
                isForcingFullScreen = false
                return false
            }
        } else {
            if UserDefaults.standard.bool(forKey: "isFullScreen") {
                isForcingFullScreen = true
                return true
            } else {
                isForcingFullScreen = false
                return false
            }
        }
    }
    
    /// Forces the screen mode to change (toggle between portrait and landscape).
    func forceScreenMode() {
        isForcingFullScreen.toggle()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: isForcingFullScreen ? .landscapeRight : .portrait))
        UIApplication.navigationTopViewController()?.setNeedsUpdateOfSupportedInterfaceOrientations()
    }
}

extension UIApplication {
    /// Retrieves the top view controller currently presented in the application's navigation stack.
    ///
    /// - Returns: An optional `UIViewController` representing the top-most view controller.
    class func navigationTopViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? UIWindowSceneDelegate,
              let window = delegate.window,
              let rootViewController = window?.rootViewController as? UINavigationController
        else {
            return nil
        }
        
        return rootViewController.topViewController
    }
}

