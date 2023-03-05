# Moonshot

<img width="300" alt="スクリーンショット 2023-03-05 18 53 38" src="https://github.com/YamamotoDesu/Moonshot/blob/main/2023-03-05%2018.54.02.gif">


<img width="514" alt="スクリーンショット 2023-03-05 18 56 27" src="https://user-images.githubusercontent.com/47273077/222953613-accaafaf-443c-45f5-b79f-d22ebaca5394.png">

```swift
struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let misssons: [Misson] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(misssons) { missson in
                        NavigationLink {
                            MissionView(mission: missson, astronauts: astronauts)
                        } label: {
                            VStack {
                                Image(missson.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(missson.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(missson.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

```

<img width="514" alt="スクリーンショット 2023-03-05 18 56 59" src="https://user-images.githubusercontent.com/47273077/222953647-f4c179ad-7d20-4a7e-84be-9014e0ba25ee.png">
```swift
struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaunt: Astronaut
    }
    
    let mission: Misson
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { gepmetry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: gepmetry.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        
                        Text("Misson Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                    }
                    .padding(.horizontal)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMeber in
                            NavigationLink {
                                AstronautView(astronaut: crewMeber.astronaunt)
                            } label: {
                                HStack {
                                    Image(crewMeber.astronaunt.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(Capsule())
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1
                                                              )
                                        )
                                    
                                    VStack(alignment: .leading) {
                                        Text(crewMeber.astronaunt.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        
                                        Text(crewMeber.role)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Misson, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaunt: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}
```



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
