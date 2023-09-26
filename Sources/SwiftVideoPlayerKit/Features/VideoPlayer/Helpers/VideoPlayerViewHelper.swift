//
//  VideoPlayerViewHelper.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 15/8/23.
//

import SwiftUI
import AVKit

/// Represents errors that might occur while using the video player.
enum VideoPlayerError: Error {
    case urlNotFounded
    
    /// A user-friendly description of the error.
    var description: String {
        switch self {
            case .urlNotFounded:
               return "Please check your network connection and try again."
        }
    }
}

/// Represents different types of sources for a video player.
public enum PlayerSource {
    /// A local video file, identified by its filename and type.
    case local(filename: String, type: String)
    /// An external video URL.
    case external(url: String)
}

/// A helper class providing utility methods for creating AVPlayer instances
/// from various video sources.
public class VideoPlayerViewHelper {
    /// Creates and returns an `AVPlayer` instance from the specified video source.
    ///
    /// - Parameter source: The source of the video, which can be either local or external.
    /// - Throws: A `VideoPlayerError.urlNotFounded` error if the URL cannot be created from the provided source.
    /// - Returns: An `AVPlayer` instance for playing the specified video source.
    public static func createAVPlayer(from source: PlayerSource) throws -> AVPlayer {
        switch source {
            case .local(let filename, let type):
                guard let fileUrl = createLocalUrl(for: filename, ofType: type) else {
                    throw VideoPlayerError.urlNotFounded
                }
                return AVPlayer(url: fileUrl)
            case .external(let url):
                guard let fileUrl = URL(string: url) else {
                    throw VideoPlayerError.urlNotFounded
                }
                return AVPlayer(url: fileUrl)
        }
    }
    
    /// Generates a local file URL for the specified video filename and type.
    ///
    /// If the video file exists in the cache, its URL is returned. Otherwise,
    /// the video is fetched from the app's assets and saved to the cache.
    ///
    /// - Parameters:
    ///   - filename: The name of the video file.
    ///   - type: The file extension of the video.
    /// - Returns: A local URL pointing to the cached video file, or `nil` if the video cannot be found.
    static func createLocalUrl(for filename: String,
                               ofType: String) -> URL? {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let url = cacheDirectory.appendingPathComponent("\(filename).\(ofType)")
        
        guard fileManager.fileExists(atPath: url.path) else {
            guard let video = NSDataAsset(name: filename)  else { return nil }
            fileManager.createFile(atPath: url.path, contents: video.data, attributes: nil)
            return url
        }
        return url
    }
}


