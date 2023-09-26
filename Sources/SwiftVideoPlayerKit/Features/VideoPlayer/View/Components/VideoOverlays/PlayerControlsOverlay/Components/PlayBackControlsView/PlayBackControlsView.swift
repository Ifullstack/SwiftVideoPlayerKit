//
//  PlayBackControlsView.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 19/8/23.
//

import SwiftUI
import AVKit

struct PlayBackControlsView: View {
    @Binding var isSeekingFoward: Bool
    @Binding var isSeekingBackward: Bool
    @Binding var showPlayerControls: Bool
    @Binding var isPlaying: Bool
    @Binding var isFinishedPlaying: Bool
    @Binding var player: AVPlayer
    @Binding var timeoutTask: DispatchWorkItem?
    var isLandscape: Bool
    
    var body: some View {
        if isSeekingFoward || isSeekingBackward {
            seekingControlsView
        } else {
            controlsView
                .padding(.top, isLandscape ? 0 : 44)
        }
    }
    
    var controlsView: some View {
        HStack(spacing: 25) {
            DefaultPlaybackButton(systemName: "backward.end.fill", action: {}).opacity(0.6)
            PlayPausePlaybackButton(systemName: isFinishedPlaying ? "arrow.clockwise" : (isPlaying ? "pause.fill" : "play.fill"))
              .scaleEffect(1.1)
              .padding(28)  // Add padding to increase the tap area
              .background(Color.clear)  // Add a clear background so the padding doesn’t affect the visual layout
              .contentShape(Rectangle())  // Set the content shape to a rectangle for hit testing
              .highPriorityGesture(
                  TapGesture()
                      .onEnded { _ in
                          playOrPauseVideo()
                      }
              )
            DefaultPlaybackButton(systemName: "forward.end.fill", action: {}).opacity(0.6)
        }
    }
    
    var seekingControlsView: some View {
        HStack() {
            if isSeekingBackward {
                VStack(alignment: .leading) {
                    SeekPlaybackButton(systemName: "backward.fill").opacity(0.6)
                    Text("10 seconds")
                        .foregroundColor(Color.white)
                        .fontWeight(.regular)
                        .font(.caption)
                }
            }
            Spacer()
            if isSeekingFoward {
                VStack(alignment: .leading) {
                    SeekPlaybackButton(systemName: "forward.fill").opacity(0.6)
                        .offset(x: isSeekingFoward ? 10 : 0)
                    Text("10 seconds")
                        .foregroundColor(Color.white)
                        .fontWeight(.regular)
                        .font(.caption)
                }
            }
        }.padding(.horizontal)
    }
}

// MARK: - Private Methods
extension PlayBackControlsView {
    private func playOrPauseVideo() {
        if isFinishedPlaying {
            isFinishedPlaying = false
            player.seek(to: .zero)
        }
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
        timeoutControls()
    }
    
    private func timeoutControls() {
        if let timeoutTask = timeoutTask {
            timeoutTask.cancel()
        }
        timeoutTask = .init(block: {
            withAnimation(.easeInOut(duration: 0.15)) {
                showPlayerControls = false
            }
        })
        
        if let timeoutTask = timeoutTask {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: timeoutTask)
        }
    }
}
