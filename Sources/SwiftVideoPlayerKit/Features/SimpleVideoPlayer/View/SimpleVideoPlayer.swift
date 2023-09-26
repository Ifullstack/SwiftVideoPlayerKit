//
//  SimpleVideoPlayer.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 17/8/23.
//


import UIKit
import AVKit
import SwiftUI
import Observation

public struct SimpleVideoPlayerView: View {
    @Bindable var viewModel: SimpleVideoPlayerViewModel
    
    private let videoPlayerSize: CGSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3.5)
    
    public var body: some View {
        ScrollView {
            if let error = viewModel.videoError {
                VideoErrorView(error: error)
                    .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
            } else {
                SimpleVideoPlayerViewRepresentable(player: $viewModel.player.wrappedValue)
                    .frame(width: videoPlayerSize.width, height: videoPlayerSize.height)
            }
        }
    }
    
    public init(viewModel: SimpleVideoPlayerViewModel) {
        self.viewModel = viewModel
    }
}


struct SimpleVideoPlayerViewRepresentable: UIViewControllerRepresentable {
    let player: AVPlayer
    
    func makeUIViewController(context: Context) -> VideoPlayerViewController {
        let controller = VideoPlayerViewController()
        controller.player = player
        return controller
    }
    
    func updateUIViewController(_ uiViewController: VideoPlayerViewController, context: Context) {
        // Update logic here, if needed
    }
}

class VideoPlayerViewController: UIViewController {
    var player: AVPlayer?
    private var playerViewController: AVPlayerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player {
            playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.videoGravity = .resizeAspectFill
            
            self.addChild(playerViewController)
            self.view.addSubview(playerViewController.view)
            playerViewController.view.frame = self.view.bounds
            playerViewController.didMove(toParent: self)
        }
    }
}
