//
//  VideoPlayerView.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 15/8/23.
//

import SwiftUI
import AVKit
import Observation

/// A view component responsible for displaying video content and its associated controls.
///
/// This view will render either a video player or an error view depending on the state of `viewModel.videoError`.
public struct VideoPlayerView: View {
    
    /// The view model responsible for managing the state and behaviors of the video player.
    @Bindable private(set) var viewModel: VideoPlayerViewModel

    /// Represents the current orientation of the device.
    @State private(set) var orientation: UIDeviceOrientation = UIDeviceOrientation.unknown {
        didSet {
            self.setDefaultOrientation()
        }
    }
    
    /// A flag indicating if the view is in landscape mode.
    @State private(set) var isLandscape: Bool = false
    
    /// Defines the default size of the video player.
    let videoPlayerSize: CGSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)

    /// The main body of the `VideoPlayerView`.
    public var body: some View {
        if let error = viewModel.videoError {
            GeometryReader { _ in
                VideoErrorView(error: error)
                    .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
            }
            
        } else {
            playerView
                .onAppear {
                    viewModel.player.addPeriodicTimeObserver(forInterval: .init(seconds: 1,
                                                             preferredTimescale: 1), queue: .main, using: { time in
                        if let currentPlayerItem: AVPlayerItem = viewModel.player.currentItem {
                            viewModel.updateVideoTimeAndProgress(from: currentPlayerItem.duration.seconds,
                                                                 currentDuration: viewModel.player.currentTime().seconds)
                        }
                    })
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.viewModel.player.currentItem, queue: .main) { _ in
                        self.viewModel.player.seek(to: .zero)
                        self.viewModel.isFinishedPlaying = false
                        self.viewModel.isPlaying = true
                        self.viewModel.player.play()
                    }
                }
                .onRotate { newOrientation in
                    if newOrientation.isPortrait {
                        viewModel.isForcingFullScreen = false
                    }
                    orientation = newOrientation
                }
                .onChange(of: viewModel.isForcingFullScreen) { _, _ in
                    orientation = viewModel.isForcingFullScreen ? .landscapeRight : .portrait
                }
        }
    }
    
    /// Initializes a new instance of the video player view.
    /// - Parameter viewModel: The view model for the video player.
    public init(viewModel: VideoPlayerViewModel) {
        self.viewModel = viewModel
    }
}

// MARK: - Player View
extension VideoPlayerView {
    /// Represents the main player view component.
    var playerView: some View {
        GeometryReader { _ in
            PlayerView(player: viewModel.player,
                       orientation: orientation)
                .portraitPlayer(isPortrait: !isLandscape,
                                videoPlayerSize: videoPlayerSize)
                .landscapePlayer(isLandscape: isLandscape)
                .overlay(PlayerControlsOverlay(viewModel: viewModel,
                                               isLandscape: isLandscape,
                                               orientation: $orientation,
                                               isShowingPlayerControls: $viewModel.isShowingPlayerControls,
                                               isPlaying: $viewModel.isPlaying,
                                               isFinishedPlaying: $viewModel.isFinishedPlaying,
                                               player: $viewModel.player,
                                               timeoutTask: $viewModel.timeoutTask))
                .overlay(alignment: .top) {
                    if viewModel.isShowingPlayerControls {
                        topOverlayViews
                    }
                }
                .overlay(alignment: .bottom) {
                    bottomOverlayViews
                }
                .onTapGesture {
                    viewModel.isShowingPlayerControls.toggle()
                }
        }
    }
}

// MARK: - Private Methods
extension VideoPlayerView {
    /// Sets the default orientation for the player based on the device's current orientation or forced full screen mode.
    private func setDefaultOrientation() {
        isLandscape = viewModel.isForcingFullScreen ? true : viewModel.isLandscapeMode(orientation: orientation)
    }
}


