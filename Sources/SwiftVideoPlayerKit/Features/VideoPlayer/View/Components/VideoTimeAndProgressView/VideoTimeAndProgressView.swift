//
//  VideoTimeAndProgressView.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 21/8/23.
//

import SwiftUI

struct VideoTimeAndProgressView: View {
    var currentProgress: Double // in seconds
    var totalLength: Double // in seconds
    
    var body: some View {
        HStack {
            Text(currentProgress.timeString)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
            Text("/")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
            Text(totalLength.timeString)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(Color.white.opacity(0.35))
        }.padding(15)
    }
}

// Extension to convert seconds to a time string (i.e., "mm:ss")
extension Double {
    var timeString: String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

