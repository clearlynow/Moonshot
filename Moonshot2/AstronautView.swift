//
//  AstronautView.swift
//  Moonshot2
//
//  Created by Alison Gorman on 2/18/21.
//

import SwiftUI

struct AstronautView: View {
    //static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut

        var matches = [Mission]()

        
        for mission in missions {
            print (String(mission.id))
            for peeps in mission.crew {
                print (String(peeps.name))
                print (astronaut.id)
                if astronaut.id == peeps.name {  //astronauts.first(where: { $0.id == member.name })
                    matches.append(mission)
                    }
                }
            }
        self.missions = matches
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(self.missions, id: \.id) { mission in
                        NavigationLink(destination: MissionView(mission: mission, astronauts: AstronautView.astronauts)) {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
