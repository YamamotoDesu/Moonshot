# Moonshot

<img width="184" alt="スクリーンショット 2023-03-04 14 50 21" src="https://user-images.githubusercontent.com/47273077/222878535-f5b64164-ec3f-4371-9b20-389caa269008.png">

```swift
 GeometryReader { geo in
            Image("anders")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.8)
                .frame(width: geo.size.width, height: geo.size.height)
        }
 ```
