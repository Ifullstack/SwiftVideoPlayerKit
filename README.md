# SwiftVideoPlayerKit

![SwiftVideoPlayerKit Banner](https://caneallestacursos.com/home/wp-content/uploads/2023/09/Youtube-Video-Player-in-SwiftUI.png)  

SwiftVideoPlayerKit is a modern, Swift-based library designed to simplify video playback in iOS applications. Seamlessly integrate video playback, controls, landscape/portrait orientations, and custom designs with just a few lines of code.

## Features

- 📹 Play local and external video sources.
- 🔄 Landscape and portrait orientation support.
- 🎛 Customizable playback controls and views.
- 🎨 Elegant default designs inspired on Youtube Video Player with options for full customization.
- 🔌 SwiftUI and UIKit compatible.

## Requirements

- iOS 17.0 or later
- Xcode 15.0 or later
  
## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/your_username/SwiftVideoPlayerKit.git", from: "1.0.0")
]
targets: [
    .target(name: "YourTarget", dependencies: ["SwiftVideoPlayerKit"])
]
```

## Usage
To use the components in your project, simply import the SwiftVideoPlayerKit module and use the components as needed.

```swift
import SwiftUI
import SwiftVideoPlayerKit

struct ContentView: View {
    var body: some View {
        // You can use this option
        VideoPlayerView(viewModel: VideoPlayerViewModel(model: VideoPlayerModel(source: .external(url: videoUrl),
                                                                                videoTitle: "Tutoriales de SwiftUI",
                                                                                videoId: "FAKE",
                                                                                channelName: "Cane Allesta",
                                                                                channelId: "FAKE",
                                                                                isAutomaticReproductionActivated: true,
                                                                                thumbnailUrl: "https://caneallestacursos.com/home/wp-content/uploads/2023/03/00-miniaturas-curso-ios-00-web-768x432.png",
                                                                                moreVideosUrls: [
                                                                                    "https://caneallestacursos.com/home/wp-content/uploads/2022/10/Unsplash-App-in-IOS-00-Empty-2-768x432.png",
                                                                                    "https://caneallestacursos.com/home/wp-content/uploads/2022/09/Recipe-App-in-IOS-0-768x432.png"
                                                                                   ])))

        // Or this more simple video player
        SimpleVideoPlayerView(viewModel: SimpleVideoPlayerViewModel(source: .external(url: videoUrl)))
    }
}
```

## Documentation

Detailed documentation for each component can be found in the [Wiki](https://github.com/Ifullstack/SwiftVideoPlayerKit/wiki) section of this repository.

## Contribution

Contributions are welcome! If you have any ideas or suggestions for improving this library, feel free to submit a pull request or create an issue. Please follow the existing coding style and ensure that your changes don't break any existing functionality.

## License

Wallapop SwiftUI Components Kit is released under the MIT License. See [LICENSE](LICENSE) for more information.




