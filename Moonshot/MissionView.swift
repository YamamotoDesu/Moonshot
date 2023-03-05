//
//  MissionView.swift
//  Moonshot
//
//  Created by 山本響 on 2023/03/05.
//

import SwiftUI

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

struct MissionView_Previews: PreviewProvider {
    static let missons: [Misson] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missons[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
