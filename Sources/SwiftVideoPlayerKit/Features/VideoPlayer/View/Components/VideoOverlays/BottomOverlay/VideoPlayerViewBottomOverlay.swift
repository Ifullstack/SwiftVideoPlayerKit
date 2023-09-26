//
//  VideoPlayerViewBottomOverlay.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 21/8/23.
//

import SwiftUI

// MARK: - Bottom Overlay
extension VideoPlayerView {
    var bottomOverlayViews: some View {
        VStack {
            if viewModel.isShowingPlayerControls {
                videoTimeAndProgressView
            }
            VideoSeekerView(progress: $viewModel.progress,
                            lastDraggedProgress: $viewModel.lastDraggedProgress,
                            isSeeking: $viewModel.isSeeking,
                            player: $viewModel.player,
                            timeoutTask: $viewModel.timeoutTask,
                            isShowingPlayerControls: $viewModel.isShowingPlayerControls,
                            isPlaying: $viewModel.isPlaying,
                            isLandscape: isLandscape,
                            videoSize: videoPlayerSize)
            if isLandscape && viewModel.isShowingPlayerControls {
                HStack {
                    videoActionsView
                    Spacer()
                    moreVideosActionsView
                }.padding(.top)
            }
        }
    }
}

// MARK: - Video Time And Progress View
extension VideoPlayerView {
    var videoTimeAndProgressView: some View {
        HStack {
            if viewModel.currentDuration != 0.0 {
                VideoTimeAndProgressView(
                    currentProgress: viewModel.currentDuration,
                    totalLength: viewModel.totalDuration
                )
            }
            Spacer()
            rotateButtonView
        }
    }
    
    var rotateButtonView: some View {
        RotatePlaybackButton(name: isLandscape ? "contraer"
                                               : "expandir") {
            
            viewModel.forceScreenMode()
        }.rotationEffect(RotationAngleHelper.rotationAngle(for: orientation))
    }
}

// MARK: - Actions
extension VideoPlayerView {
    var videoActionsView: some View {
        HStack(spacing: 24) {
            Image(systemName: "hand.thumbsup")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image(systemName: "hand.thumbsdown")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image(systemName: "ellipsis.message")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image(systemName: "message")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image(systemName: "plus.square.on.square")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image(systemName: "arrowshape.turn.up.forward")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image(systemName: "ellipsis")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
        }
    }
    
    var moreVideosActionsView: some View {
        HStack(spacing: 16) {
            moreVideosActionsTextsView
            thumbnailImagesDeckView
        }
    }
    
    var thumbnailImagesDeckView: some View {
        ZStack {
            ForEach(viewModel.model.getMoreVideosUrlsStack().indices, id: \.self) { index in
                ThumbnailImageView(url: viewModel.model.getMoreVideosUrlsStack()[index])
                    .frame(width: 100 + CGFloat(index) * 10, height: 60)
                    .offset(y: CGFloat(-16 + index * 8))
                    .opacity(0.5 + 0.3 * CGFloat(index))
            }
        }
    }
    
    var moreVideosActionsTextsView: some View {
        VStack(alignment: .trailing) {
            Text("More Videos")
                .foregroundColor(Color.white)
                .fontWeight(.heavy)
                .font(.headline)
            Text("Tap or swipe up to see all")
                .foregroundColor(Color.init(uiColor: UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1)))
                .fontWeight(.regular)
                .font(.subheadline)
        }
    }
}
