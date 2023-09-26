//
//  PlayerControlsOverlay.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 15/8/23.
//

import SwiftUI
import AVKit

struct PlayerControlsOverlay: View {
    var viewModel: VideoPlayerViewModel
    var isLandscape: Bool
    
    @Binding var orientation: UIDeviceOrientation
    @Binding var isShowingPlayerControls: Bool
    @Binding var isPlaying: Bool
    @Binding var isFinishedPlaying: Bool
    @Binding var player: AVPlayer
    @Binding var timeoutTask: DispatchWorkItem?
    
    @State var isSeekingFoward: Bool = false
    @State var isSeekingBackward: Bool = false
    @GestureState private var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            if isShowingPlayerControls {
                playbackControls
            }
            if isPlaying {
                seekingControls
            }
        }
    }
    
    var playbackControls: some View {
        Rectangle()
            .fill(Color.black.opacity(0.4))
            .opacity(isShowingPlayerControls || isDragging ? 1 : 0)
            .animation(.easeInOut(duration: 0.35), value: isDragging)
            .overlay {
                PlayBackControlsView(isSeekingFoward: $isSeekingFoward,
                                     isSeekingBackward: $isSeekingBackward,
                                     showPlayerControls: $isShowingPlayerControls,
                                     isPlaying: $isPlaying,
                                     isFinishedPlaying: $isFinishedPlaying,
                                     player: $player,
                                     timeoutTask: $timeoutTask,
                                     isLandscape: isLandscape)
                    .rotationEffect(RotationAngleHelper.rotationAngle(for: orientation))
            }
            .edgesIgnoringSafeArea(.all)
    }
    
    var seekingControls: some View {
        HStack {
            // Left Side
            ZStack {
                Color.clear
            }
            .frame(width: UIScreen.main.bounds.width / 2)
            .contentShape(Rectangle())
            .onTapGesture(count: 2, perform: {
                seek(by: -20) // Seek backward by 20 seconds
                isSeekingBackward = true
            })
            
            // Right Side
            ZStack {
                Color.clear
            }
            .frame(width: UIScreen.main.bounds.width / 2)
            .contentShape(Rectangle())
            .onTapGesture(count: 2, perform: {
                seek(by: 20) // Seek forward by 20 seconds
                isSeekingFoward = true
            })
        }
    }
}

// MARK: - Private Methods
extension PlayerControlsOverlay {
    private func seek(by seconds: Double) {
        if let currentPlayerItem = player.currentItem {
            let totalDuration = currentPlayerItem.duration.seconds
            let currentDuration = player.currentTime().seconds
            var newDuration = currentDuration + seconds
            
            // Make sure newDuration is within the bounds
            newDuration = max(0, newDuration)
            newDuration = min(totalDuration, newDuration)
            
            let seekToTime = CMTimeMakeWithSeconds(newDuration, preferredTimescale: 1)
            player.seek(to: seekToTime)
            viewModel.updateVideoTimeAndProgress(from: totalDuration, currentDuration: newDuration)
            isSeekingTimeoutControls()
        }
    }
    
    private func isSeekingTimeoutControls() {
        if let timeoutTask = timeoutTask {
            timeoutTask.cancel()
        }
        timeoutTask = .init(block: {
            withAnimation(.easeInOut(duration: 0.15)) {
                isSeekingFoward = false
                isSeekingBackward = false
            }
        })
        if let timeoutTask = timeoutTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: timeoutTask)
        }
    }
}



