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


LazyVStack and LazyHStack can be used in exactly the same way as regular stacks but will load their content on-demand – they won’t create views until they are actually shown, and so minimize the amount of system resources being used.

```swift
LazyVStack(spacing: 10) {
    ForEach(0..<100) {
        CustomText("Item \($0)")
            .font(.title)
    }
}
.frame(maxWidth: .infinity)

```
Literally all it takes is to add “Lazy” before “VStack” to have our code run more efficiently – it will now only create the CustomText structs when they are actually needed.

