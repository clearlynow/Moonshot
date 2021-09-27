//
//  ContentView.swift
//  Moonshot2
//
//  Created by Alison Gorman on 2/18/21.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State var subtitleCrew = false
    
    struct CrewMember {
        var role: String
        var astronaut: Astronaut
    }
    
    
    var body: some View {

        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if subtitleCrew {
                            Text(mission.formattedLaunchDate)
                        }
                        else {
                            ForEach(mission.crew, id: \.name) { member in
                                if let match = astronauts.first(where: { $0.id == member.name }) {
                                    Text(match.name)
                                }
                            }
                            
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .toolbar {
                Button(subtitleCrew ? "Show Crew" : "Show Launch Date") {
                    subtitleCrew.toggle()
                }
            }
        }
        .padding(.bottom, 1)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
