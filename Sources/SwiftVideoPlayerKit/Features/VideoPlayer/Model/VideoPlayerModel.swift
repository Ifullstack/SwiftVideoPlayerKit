//
//  VideoDataModel.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 21/8/23.
//

import Foundation

public struct VideoPlayerModel {
    let source: PlayerSource
    let videoTitle: String
    let videoId: String
    let channelName: String
    let channelId: String
    var isAutomaticReproductionActivated: Bool
    let thumbnailUrl: String
    let moreVideosUrls: [String] 
    
    func getMoreVideosUrlsStack() -> [String] {
        var urls: [String] = []
        urls.append(contentsOf: moreVideosUrls)
        urls.append(thumbnailUrl)
        return Array(urls.prefix(3))
    }
    // You can extends or replace this properties as much as you need
    
    public init(source: PlayerSource,
                videoTitle: String,
                videoId: String,
                channelName: String,
                channelId: String,
                isAutomaticReproductionActivated: Bool,
                thumbnailUrl: String,
                moreVideosUrls: [String]) {
        self.source = source
        self.videoTitle = videoTitle
        self.videoId = videoId
        self.channelName = channelName
        self.channelId = channelId
        self.isAutomaticReproductionActivated = isAutomaticReproductionActivated
        self.thumbnailUrl = thumbnailUrl
        self.moreVideosUrls = moreVideosUrls
    }
    
    // Empty for Error State
    init() {
        self.source = .external(url: "")
        self.videoTitle = ""
        self.videoId = ""
        self.channelName = ""
        self.channelId = ""
        self.isAutomaticReproductionActivated = false
        self.thumbnailUrl = ""
        self.moreVideosUrls = []
    }
}
