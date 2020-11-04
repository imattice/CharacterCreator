//
//  LanguageSelectionView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/3/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct LanguageSelectionView: View {
//    @State var availableSelections: Int
    @Binding var selectedLanguages: [Language]
    @State var knownLanguages: [String]
    let common: [LanguageRecord]
    let exotic: [LanguageRecord]
    
    var body: some View {
        List {
            Section(header: Text("Common Languages")) {
                ForEach(common) { language in
                    LanguageCell(language: language, selectedLanguages: $selectedLanguages)
                }
            }
            Section(header: Text("Exotic Languages")) {
                ForEach(exotic) { language in
                    LanguageCell(language: language, selectedLanguages: $selectedLanguages)
                    
                }
            }
        }
    }
    
    init(known: [String], selected: Binding<[Language]>) {
        let languages = LanguageRecord.all().filter { $0.isSecret == false }
        self.common = languages.filter { $0.isExotic == false }
        self.exotic = languages.filter { $0.isExotic == true }

        self._knownLanguages = State(wrappedValue: known)
        self._selectedLanguages = selected
    }
}

struct LanguageSelectionView_Previews: PreviewProvider {
    @State static var selected = [
        Language(name: "abyssal", isSelectable: true, source: .race),
        Language(name: "goblin", isSelectable: true, source: .race)]

    static var previews: some View {
        LanguageSelectionView(known: [String](), selected: $selected)
    }
}

struct LanguageCell: View {
    let language: LanguageRecord
    @State var selected: Bool = false
    @Binding var selectedLanguages: [Language]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
            Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(Color.App.primary)
            Text(language.name.capitalized)
//            Text(language.description)
//                .font(.caption)
//            Text("\(language.name.capitalized) is commonly spoken by \(language.spokenBy)")
//            Spacer()
            }
            
        }.onTapGesture {
            selected = !selected
            if selected {
                selectedLanguages.append(Language(name: language.name, isSelectable: true, source: .race))
            }
            else {
                guard let index = selectedLanguages.firstIndex(where: { $0.name == language.name }) else { return }
                selectedLanguages.remove(at: index)
            }
        }
        .listRowBackground(selected ? Color.App.surface : Color.white)
        

        
//        Button(action: {
//            selected = !selected
//            if selected {
//                selectedLanguages.append(Language(name: language.name, isSelectable: true, source: .race))
//            }
//            else {
//                guard let index = selectedLanguages.firstIndex(where: { $0.name == language.name }) else { return }
//                selectedLanguages.remove(at: index)
//            }
//        },
//               label: {
//            VStack(alignment: .leading) {
//                Text(language.name.capitalized)
//    //            Text(language.description)
//    //                .font(.caption)
//    //            Text("\(language.name.capitalized) is commonly spoken by \(language.spokenBy)")
//            }
//            .background(selected ? Color.white : Color.App.surface)
//        })

    }
}
