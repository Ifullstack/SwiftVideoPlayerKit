//
//  ThumbnailImageView.swift
//  YoutubeVideoPlayerSwiftUI
//
//  Created by Cane Allesta on 21/8/23.
//

import SwiftUI

struct ThumbnailImageView: View {
    var url: String 
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .cornerRadius(8)
        } placeholder: {
            ProgressView()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.white, lineWidth: 1)
        )
    }
}


