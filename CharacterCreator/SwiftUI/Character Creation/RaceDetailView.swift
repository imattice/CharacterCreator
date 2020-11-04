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
    @State var languageSelectionIsShown: Bool = false
    @State var languageSelection: [Language] = [Language]()
    
    let hasSelectableLanguage: Bool
    var selectedLanguage: Language?
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
//                VStack {
//                List {
                    Image(race.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 70, maxWidth: 150,
                               minHeight: 70, maxHeight: 150)
                        

                    Text(race.description)
                        .padding()
                        .font(.body)
                        .background(Color.App.surface)
                        .cornerRadius(10)

//                    Divider()
                    HStack {
                        CreatureSizeView(race: race)
                        Spacer()
                        AbilityScoreModifierDisplayView(modifiers: race.modifiers.ofType(AbilityScoreModifier.self))
                        Spacer()
                        SpeedView(speed: race.speed)

                    }
                    .padding()
                    Divider()
                    
                    if hasSelectableLanguage {
                    NavigationLink(
                        destination: LanguageSelectionView(known: race.baseLanguages, selected: $languageSelection),
                        isActive: $languageSelectionIsShown,
                        label: {
                            VStack {
                                Text(languageString)
                                    .multilineTextAlignment(.center)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding()
                                
                            Text("Selected Language: ")
                                .foregroundColor(.black)
                            + Text(selectedLanguage?.name ?? "None")
                                .foregroundColor(Color.App.primary)
                            }
                            })
                    }
                    else {
                        Text(languageString)
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .foregroundColor(.black)
                    }

//                    ForEach(race.features) { feature in
//                        VStack{
//                            Text(feature.title)
//                            Text(feature.description)
//                        }
//                    }
//                    ForEach(race.subrace) { subrace in
//                        Text(subrace.title)
//                        Text(subrace.description)
//                        Text(subrace.stats)
//                        ForEach(subrace.features) { feature in
//                            VStack{
//                                Text(feature.title)
//                                Text(feature.description)
//                            }
//                        }
//                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                
                
            }
            .background(Color.App.background)
        }
    }
    
    ///a string that combines the values in baseLanguages, including joining language such as "and"
    var languageString: String {
        let mapped: [String] = race.baseLanguages.indices.map {
            let language = race.baseLanguages[$0]
            var result = ""

            if language == "choice" {
                return "a language of your choice" }
            else {  result += "\(language.capitalized)," }
            
            if race.baseLanguages.count > 1 && $0 == race.baseLanguages.count - 2 {
                result.removeLast()
                result += " and" }
            if $0 == race.baseLanguages.count - 1 { result.removeLast() }
            
            return result
        }
        
        return "\(race.name.capitalized) natively know \(race.baseLanguages.count) languages: \n\( mapped.joined(separator: " "))"
    }
    
    init(record: RaceRecord) {
        self._race = State(wrappedValue: record)
        self.hasSelectableLanguage = record.baseLanguages.contains("choice")
    }
    
    
}

struct RaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RaceDetailView(record: RaceRecord.record(for: "human")!)
            RaceDetailView(record: RaceRecord.record(for: "dwarf")!)
            RaceDetailView(record: RaceRecord.record(for: "halfling")!)
                .previewDevice("iPhone 11 Pro Max")
        }
        
    }
}

struct CreatureSizeView: View {
    @State var race: RaceRecord
    
    var body: some View {
        ZStack {
            BackgroundCircle()
//            Image(race.size.rawValue)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 70, height: 70)
//                .frame(minWidth: 40, maxWidth: 40,
//                       minHeight: 40, maxHeight: 40)
//                .padding(.top, -10)
//                .opacity(0.5)
        VStack {
            Text("Size")
                .font(Font.callout.bold())
            Text(race.size.rawValue.capitalized)
                .font(.caption)
//                .padding
//                .padding(.top, -15)
            
        }
    }
    }
}
struct SpeedView: View {
    @State var speed: Int
    var body: some View {
        ZStack {
            BackgroundCircle()
            VStack {
                Text("Speed")
                    .font(Font.callout.bold())
                Text(String(speed))
                    .font(.caption)
                
            }
        }
    }
}


struct AbilityScoreModifierDisplayView: View {
    @State var modifiers: [AbilityScoreModifier]
    
    var body: some View {
        VStack {
            if modifiers.count > 3 {
                let first = Array(modifiers[0...1])
                let second = Array(modifiers[2...3])
                let third = Array(modifiers[4...5])
                ForEach([first, second, third], id:\.self) { array in
                    HStack {
                        ForEach(array) { modifier in
                            AbilityScoreModifierPillView(modifier: modifier.value, abilityScore: modifier.abilityScore)
                        }
                    }
                }

                
//                HStack {
//                    ForEach(firstHalf) { modifier in
//                        Text("+\(modifier.value) \(modifier.abilityScore.rawValue.capitalized)")
//                            .font(.caption)
//                            .padding(8)
//                            .background(Color.primaryHighlight)
//                            .cornerRadius(30)
//                    }
//                }
//                HStack {
//                    ForEach(secondHalf) { modifier in
//                        Text("+\(modifier.value) \(modifier.abilityScore.rawValue.capitalized)")
//                            .font(.caption)
//                            .padding(8)
//                            .background(Color.primaryHighlight)
//                            .cornerRadius(30)
//                    }
//                }
            }
            else {
                ForEach(modifiers) { modifier in
                    Text("+\(modifier.value) \(modifier.abilityScore.rawValue.capitalized)")
                        .font(.caption)
                        .padding(8)
                        .background(Color.App.primaryHighlight)
                        .cornerRadius(30)
                }
            }
        }
    }
}

fileprivate
struct BackgroundCircle: View {
    let dimension: CGFloat = 60
    let min: CGFloat = 60
    let ideal: CGFloat = 70
    let max: CGFloat = 80
    
    var body: some View {
        Circle()
            .foregroundColor(Color.App.primaryHighlight)
            .frame(minWidth: min, idealWidth: ideal, maxWidth: max,
                   minHeight: min, idealHeight: ideal, maxHeight: max)
    }
}

struct AbilityScoreModifierPillView: View {
    @State var modifier: Int
    @State var abilityScore: AbilityScore.Name
    
    
    var body: some View {
        Text("+\(modifier) \(abilityScore.rawValue.capitalized)")
            .frame(width: 50, height: 20)
            .frame(minWidth: 50, idealWidth: 60,
                   minHeight: 20, idealHeight: 25, maxHeight: 25)
            .font(.caption)
            .padding(8)
            .background(Color.App.primaryHighlight)
            .cornerRadius(30)
    }
}
