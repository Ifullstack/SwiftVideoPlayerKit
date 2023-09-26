//
//  SwiftUIView.swift
//  
//
//  Created by Cane Allesta on 26/9/23.
//

import SwiftUI

struct VideoErrorView: View {
    var error: VideoPlayerError
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(Color.gray)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("An error occurred")
                    .font(.headline)
                    .foregroundColor(Color.gray)
                Text(error.description)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.gray)
                    .padding(.horizontal, 0)
                
                Button(action: {
                    // Handle action
                }, label: {
                    Text("Learn More")
                        .font(.headline)
                        .foregroundColor(.white)
                        .underline()
                })
            }
        }
        .padding(.all, 50)
    }
}

