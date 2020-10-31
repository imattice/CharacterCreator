//
//  RaceDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct RaceDetailView: View {
    @State var race: RaceRecord
    
    var body: some View {
        NavigationView {
            VStack {
                Image(race.name)
                Text(race.description)
                HStack {
                    Text(race.size.rawValue)
                    Text(race.modifiers)
                    Text(race.speed)
                }
                Text(race.languageString)
                ForEach(race.features) { feature in
                    VStack{
                        Text(feature.title)
                        Text(feature.description)
                    }
                }
                ForEach(race.subrace) { subrace in
                    Text(subrace.title)
                    Text(subrace.description)
                    Text(subrace.stats)
                    ForEach(subrace.features) { feature in
                        VStack{
                            Text(feature.title)
                            Text(feature.description)
                        }
                    }
                }
                
            }
        }
    }
}

struct RaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RaceDetailView(race: RaceRecord.all().first!)
    }
}
