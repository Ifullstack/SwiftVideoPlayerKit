//
//  VideoPlayerViewTopOverlay.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 21/8/23.
//

import SwiftUI

// MARK: - Top Overlay
extension VideoPlayerView {
    var topOverlayViews: some View {
        HStack(alignment: .top) {
            if isLandscape {
                channelAndVideoTitleView
            } else {
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.white)
                    .fontWeight(.regular)
                    .font(.system(size: 20))
                    .padding(.leading)
            }
            Spacer()
            videoPropertiesView
        }.padding(.top)
            .offset(x:-4)
    }
}

// MARK: - Channel and Video Title
extension VideoPlayerView {
    var channelAndVideoTitleView: some View {
        VStack(alignment: .leading) {
            HStack {
                videoTitleView
                chevronView
            }
            channelNameView
        }
    }
    
    var videoTitleView: some View {
        Text(viewModel.model.videoTitle)
            .foregroundColor(Color.white)
            .fontWeight(.heavy)
            .font(.title2)
    }
    
    var channelNameView: some View {
        Text(viewModel.model.channelName)
            .foregroundColor(Color.init(uiColor: UIColor(red: 0.702, green: 0.702, blue: 0.702, alpha: 1)))
            .fontWeight(.bold)
            .font(.title3)
    }
    
    var chevronView: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(Color.white)
            .fontWeight(.regular)
            .font(.title2)
    }
}

// MARK: - Video Properties Icon
extension VideoPlayerView {
    var videoPropertiesView: some View {
        HStack(spacing: 24) {
            Toggle("", isOn: $viewModel.model.isAutomaticReproductionActivated)
                .frame(width: 20, height: 20)
                .toggleStyle(YoutubeToggleStyle())
                .padding(.trailing, 8)
            Image(systemName: "airplayvideo")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
            Image("subtitulos")
                .resizable()
                .frame(width: 20, height: 20)
            Image(systemName: "gearshape")
                .foregroundColor(Color.white)
                .fontWeight(.regular)
                .font(.system(size: 20))
        }.padding(.trailing)
    }
}


