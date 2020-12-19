//
//  RaceDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct RaceDetailView: View {
    @EnvironmentObject var selectedRace: SelectedRace
    @State var languageSelectionIsShown: Bool = false
    @State var selectedLanguages: [Language] = [Language]()
        
    var body: some View {
            VStack {
                ScrollView {
                    HeaderView()
                    Divider()
                    LanguageView(selectedLanguages: $selectedLanguages,
                                 languageSelectionIsShown: $languageSelectionIsShown)
                        .frame(maxWidth: .infinity)
                    Divider()
                    FeatureStack(features: selectedRace.record.features)
                    Divider()
                    SubraceStack()
                }
                SelectionButton()
            }
            .background(Color.App.background)
            .navigationTitle(selectedRace.record.name.capitalized)
            .navigationBarTitleDisplayMode(.inline)
    }
}

fileprivate
struct HeaderView: View {
    @EnvironmentObject var selectedRace: SelectedRace
    
    var body: some View {
        VStack {
            Image(selectedRace.record.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 70, maxWidth: 150,
                       minHeight: 70, maxHeight: 150)
            
            Text(selectedRace.record.description)
                .padding()
                .font(Font.App.caption)
                .background(Color.App.surface)
                .cornerRadius(10)
            
            HStack {
                CreatureSizeView(race: selectedRace.record)
                Spacer()
                AbilityScoreModifierDisplayView(modifiers: selectedRace.record.abilityScoreModifiers)
                Spacer()
                SpeedView(speed: selectedRace.record.speed)
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .padding()

    }
}

fileprivate
struct LanguageView: View {
    @EnvironmentObject var selectedRace: SelectedRace
    @Binding var selectedLanguages: [Language]
    @Binding var languageSelectionIsShown: Bool


    var body: some View {
        Group{
            if selectedRace.record.baseLanguages.map({ $0.name }).contains("choice") {
                NavigationLink(
                    destination: LanguageSelectionView(known: selectedRace.record.baseLanguages,
                                                       selected: $selectedLanguages),
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
                            + Text(selectedLanguages.isEmpty ? "None" :
                                    selectedLanguages.map({ $0.name.capitalized }).joined(separator: ", "))
                            .foregroundColor(Color.App.primary)
                        }
                    })}
            else {
                Text(languageString)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)

    }
    
    ///a string that combines the values in baseLanguages, including joining language such as "and"
    var languageString: String {
        let record: RaceRecord = selectedRace.record
        let mapped: [String] = record.baseLanguages.indices.map {
            let language = record.baseLanguages[$0]
            var result = ""

            if language.name == "choice" {
                return "a language of your choice" }
            else {  result += "\(language.name.capitalized)," }
            
            if record.baseLanguages.count > 1 && $0 == record.baseLanguages.count - 2 {
                result.removeLast()
                result += " and" }
            if $0 == record.baseLanguages.count - 1 { result.removeLast() }
            
            return result
        }
        
        return "\(record.name.capitalized) natively know \(record.baseLanguages.count) languages: \n\( mapped.joined(separator: " "))"
    }
}

struct FeatureStack: View {
    @State var features: [Feature]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(features) { feature in
                if let selectableFeature = feature as? SelectableFeature {
                    SelectableFeaturePanel()
                        .environmentObject(selectableFeature)
                }
                VStack(alignment: .leading) {
                    Text(feature.title)
                        .font(Font.App.header)
                    Text(feature.description)
                        .font(Font.App.caption)
                        .lineLimit(nil)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.App.surface)
                .cornerRadius(10)
            }
        }
    }
}


struct SubraceStack: View {
    @EnvironmentObject var selectedRace: SelectedRace
    var subraces: [SubraceRecord] {
        selectedRace.record.subraces
    }

    var body: some View {
        VStack {
            ForEach(subraces) { subrace in
                VStack {
                    Text(subrace.name)
                    Text(subrace.description)
                    AbilityScoreModifierDisplayView(modifiers: subrace.abilityScoreModifiers)
                    FeatureStack(features: subrace.features)
                }
            }
        }
    }
}

//MARK: - Previews
struct RaceDetailView_Previews: PreviewProvider {
    @Binding var selection: String
    
    static var previews: some View {
        Group {
            //Test Devices
            Group {
                NavigationView {
                RaceDetailView()
                    .environmentObject(SelectedRace(RaceRecord.record(for: "human")!))
                }
                    .previewDevice("iPhone 11 Pro Max")
                NavigationView {
                RaceDetailView()
                    .environmentObject(SelectedRace(RaceRecord.record(for: "dwarf")!))
                }
                RaceDetailView()
                    .environmentObject(SelectedRace(RaceRecord.record(for: "halfling")!))
            }
            
            //Components
            Group {
                HeaderView()
                    .environmentObject(SelectedRace(RaceRecord.record(for: "dwarf")!))

                FeatureStack(features: RaceRecord.record(for: "dwarf")!.features)

                SubraceStack()
                    .environmentObject(SelectedRace(RaceRecord.record(for: "dwarf")!))
                
            }
            .previewLayout(.sizeThatFits)
        }
    }
}



//MARK: - Helper Views
fileprivate
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

fileprivate
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

fileprivate
struct AbilityScoreModifierDisplayView: View {
    @State var modifiers: [AbilityScoreModifier]
    
    var body: some View {
        VStack {
            //display mode for if there are 4 or more stats
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
            }
            //display mode for if there are 3 or fewer stats
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

fileprivate
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

struct RaceDetailLanguageView: View {
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




struct SelectionButton: View {
    var body: some View {
        Button(action: {
            print("hi")
        }, label: {
            Text("Choose")
                .padding()
                .background(Color.App.primary)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding(.bottom)
        })
    }
}
