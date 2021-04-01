//
//  RaceDetailView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/27/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

///Displays the details of a specific race
struct RaceDetailView: View {
    @EnvironmentObject var selectedRace: SelectedRace
    @State var languageSelectionIsShown: Bool = false
    @State var selectedLanguages: [Language] = [Language]()
        
    var body: some View {
            VStack {
                ScrollView {
                    //Display an image, descriptoin, size, speed and ability score benefits for this race
                    HeaderView()
                    Divider()
                    
                    //Show the lanagues that are inherant to the race, as well as any that can be selected
                    LanguageView(selectedLanguages: $selectedLanguages,
                                 languageSelectionIsShown: $languageSelectionIsShown)
                    
                    //Show racial features if there are any
                    if !selectedRace.record.features.isEmpty {
                        Divider()
                        FeatureStack(title: selectedRace.record.name,
                                     selectedRace.record.features)
                            .padding()
                    }
                    //Show subraces if there are any
                    if !selectedRace.record.subraces.isEmpty {
                        Divider()

                        SubraceStack()
                    }
                }

                SelectionButton()
            }
            .background(Color.App.background)
            .navigationTitle(selectedRace.record.name.capitalized)
            .navigationBarTitleDisplayMode(.large)

    }
}

///displays an image, size, speed, ability score modifiers and the description for the race
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
            
            DescriptionPanel(selectedRace.record.description)
            
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

///displays languages that are natively known to this race
///if a selection can be made, tap for a selection view
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
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(10)
        .padding()
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

///a panel view for showing details for a given feature
fileprivate
struct SubracePanel: View {
    let record: SubraceRecord
    
    var body: some View {
        VStack {
            Text(record.name.capitalized)
                .font(.title2)
            DescriptionPanel(record.description)
            AbilityScoreModifierDisplayView(modifiers: record.abilityScoreModifiers)
            FeatureStack(title: record.name.capitalized, record.features)
        }
        .padding(8)
        .background(Color.white)
        .foregroundColor(.black )
        .cornerRadius(10)
    }
    
    init(_ record: SubraceRecord) {
        self.record = record
    }
}

///a view showing multiple subraces in a vstack
fileprivate
struct SubraceStack: View {
    @EnvironmentObject var selectedRace: SelectedRace
    
    var subraces: [SubraceRecord] {
        return selectedRace.record.subraces
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(selectedRace.record.name.capitalized) Heritages")
                .font(.title)
            DescriptionPanel("\(selectedRace.record.name.capitalized) come in many varieties.  Choose the type of \(selectedRace.record.name.capitalized) that best represents your character's backgound.")
                .font(.caption)
            VStack {
                ForEach(subraces) { subrace in
                    Divider()
                    SubracePanel(subrace)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .padding()
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

                FeatureStack(title: RaceRecord.record(for: "dwarf")!.name,
                             RaceRecord.record(for: "dwarf")!.features)


                SubraceStack()
                    .environmentObject(SelectedRace(RaceRecord.record(for: "dwarf")!))
                
            }
            .previewLayout(.sizeThatFits)
        }
    }
}



//MARK: - Helper Views

///a view for displaying a creature's size category
fileprivate
struct CreatureSizeView: View {
    @State var race: RaceRecord
    
    var body: some View {
        ZStack {
            BackgroundCircle()
            VStack {
                Text("Size")
                    .font(Font.callout.bold())
                Text(race.size.rawValue.capitalized)
                    .font(.caption)
            }
        }
        .foregroundColor(.black )

    }
}

///a view for displaying the speed of a creature
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
        .foregroundColor(.black )
    }
}

/// displays the modifier value of a single ability modifier
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
            .foregroundColor(.black )
            .cornerRadius(30)
    }
}


///a view for displaying all ability modifiers in a stack or grid pattern, depending on the count of modifiers
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
        .foregroundColor(.black )

    }
}

///a circular view to be used as a background
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
