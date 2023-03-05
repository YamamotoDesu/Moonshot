# Moonshot

<img width="300" alt="スクリーンショット 2023-03-05 18 53 38" src="https://user-images.githubusercontent.com/47273077/222953523-3034292c-1a89-4f03-9693-d95ca4d12cf1.png">


----------

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

![2023-03-04 15 14 57](https://user-images.githubusercontent.com/47273077/222879462-572dced4-90c6-4fc1-ae62-03c90992aafd.gif)

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

<img width="514" alt="スクリーンショット 2023-03-04 16 19 27" src="https://user-images.githubusercontent.com/47273077/222881903-bfec29a8-9a27-42cf-bf3c-f1530194bffc.png">

```swift
    let input = [
        GridItem(.fixed(80)),
        GridItem(.fixed(80)),
        GridItem(.fixed(80))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: input) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
 ```
 
 <img width="514" alt="スクリーンショット 2023-03-04 16 21 25" src="https://user-images.githubusercontent.com/47273077/222881997-1848a19f-34d2-4e64-8dd8-07547ad147a2.png">
 
 ```swift
  let input = [
        GridItem(.adaptive(minimum: 80))
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: input) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
```
