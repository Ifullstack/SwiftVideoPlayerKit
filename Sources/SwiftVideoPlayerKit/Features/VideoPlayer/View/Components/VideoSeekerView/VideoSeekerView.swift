//
//  VideoSeekerView.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 15/8/23.
//

import SwiftUI
import AVKit

struct VideoSeekerView: View {
    @Binding var progress: CGFloat
    @Binding var lastDraggedProgress: CGFloat
    @Binding var isSeeking: Bool
    @Binding var player: AVPlayer
    @Binding var timeoutTask: DispatchWorkItem?
    @Binding var isShowingPlayerControls: Bool
    @Binding var isPlaying: Bool
    var isLandscape: Bool
    
    @GestureState private var isDragging: Bool = false
    
    var videoSize: CGSize
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.clear)
            ZStack(alignment: .leading) {
                if isShowingPlayerControls {
                    fullVideoLenghtRectangle
                    progressRectangleRed
                } else {
                    if !isLandscape && isPlaying {
                        progressRectangleWhite
                    }
                }
            }
            if isShowingPlayerControls {
                dragKnob
            }
        }
        .frame(height: 5)
    }
}

// MARK: - Progress Rectangle
extension VideoSeekerView {
    var fullVideoLenghtRectangle: some View {
        Rectangle()
            .fill(.gray)
            .frame(height: 3)
    }
    
    var progressRectangleRed: some View {
        Rectangle()
            .fill(Color.red)
            .frame(width: max(videoSize.width * (progress.isNaN ? 0.0 : progress), 0), height: 3)
    }
    
    var progressRectangleWhite: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: max(videoSize.width * (progress.isNaN ? 0.0 : progress), 0), height: 3)
    }
}

// MARK: - Drag Knob
extension VideoSeekerView {
    var dragKnob: some View {
        Circle()
            .fill(Color.red)
            .frame(width: 15, height: 15)
            .scaleEffect(isDragging || progress > 0 ? 1 : 0.001, anchor: progress * videoSize.width > 15 ? .trailing : .leading)
            .frame(width: 50, height: 50)
            .contentShape(Rectangle())
            .offset(x: videoSize.width * progress)
            .gesture(
                DragGesture()
                    .updating($isDragging, body: { _, out, _ in
                        out = true
                    })
                    .onChanged(onDragChanged)
                    .onEnded(onDragEnded)
            )
            .offset(x: progress * videoSize.width > 15 ? -15 : 0)
            .frame(width: 15, height: 15)
    }
}

// MARK: - Private Methods
extension VideoSeekerView {
    private func onDragChanged(value: DragGesture.Value) {
        if let timeoutTask = timeoutTask {
            timeoutTask.cancel()
        }
        let translationX: CGFloat = value.translation.width
        let calculatedProgress = (translationX / videoSize.width) + lastDraggedProgress
        progress = max(min(calculatedProgress, 1), 0)
        isSeeking = true
    }
    
    private func onDragEnded(value: DragGesture.Value) {
        lastDraggedProgress = progress
        
        if let currentPlayerItem = player.currentItem {
            let totalDuration = currentPlayerItem.duration.seconds
            player.seek(to: .init(seconds: totalDuration * Double(progress), preferredTimescale: 1))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isSeeking = false
            }
        }
    }
}
