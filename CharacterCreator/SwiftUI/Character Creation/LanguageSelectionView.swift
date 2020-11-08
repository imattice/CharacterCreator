//
//  LanguageSelectionView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/3/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct LanguageSelectionView: View {
    ///an array that holds the languages that are selected in this view
    @Binding var selectedLanguages: [Language]
    ///an array that holds languages already known from other sources
    var knownLanguages: [Language]
    ///all common languages
    let common: [LanguageRecord]
    ///all exotic languages
    let exotic: [LanguageRecord]
    ///all known secret languages
    let knownSecretLanguages: [LanguageRecord]
    ///the total selections that can be made in this view
    let maxSelections: Int
    ///the number of selections made in this view
    var selectionsMade: Int { return selectedLanguages.count }
    
    var body: some View {
        VStack {
            ///show the number of selctions made
            Text("Choose \(selectionsMade) additional languages")
            ///list all possible language selections
        List {
            ///common languages
            Section(header: Text("Common Languages")) {
                ForEach(common) { language in
                    
                    LanguageCell(for: language,
                                 selectedLanguages: $selectedLanguages,
                                 isSelected: selectedLanguages.contains(where: { $0.name == language.name }),
                                 isKnown: knownLanguages.contains(where: { $0.name == language.name }),
                                 maxSelections: maxSelections)
                }
            }
            ///exotic languages
            Section(header: Text("Exotic Languages")) {
                ForEach(exotic) { language in
                    LanguageCell(for: language,
                                 selectedLanguages: $selectedLanguages,
                                 isSelected: selectedLanguages.contains(where: { $0.name == language.name }),
                                 isKnown: knownLanguages.contains(where: { $0.name == language.name }),
                                 maxSelections: maxSelections)
                }
            }
            
            ///any known secret languages
            if !knownSecretLanguages.isEmpty {
                Section(header: Text("Secret Languages")) {
                    ForEach(knownSecretLanguages) { language in
                LanguageCell(for: language,
                             selectedLanguages: $selectedLanguages,
                             isSelected: selectedLanguages.contains(where: { $0.name == language.name }),
                             isKnown: knownLanguages.contains(where: { $0.name == language.name }),
                             maxSelections: maxSelections)
                    }
                }
            }
        }
        }
    }
    
    init(known: [Language], selected: Binding<[Language]>, maxSelections: Int = 1) {
        let languages = LanguageRecord.all().filter { $0.isSecret == false }
        self.common = languages.filter { $0.isExotic == false }
        self.exotic = languages.filter { $0.isExotic == true }
        self.knownSecretLanguages = known.filter { $0.record?.isSecret == true }.map { ($0.record!) }
        
        self.maxSelections = maxSelections
        self.knownLanguages = known

        self._selectedLanguages = selected
    }
}



struct LanguageCell: View {
    ///deterimines if the cell is selected or not
    @State var isSelected: Bool
    ///an array that holds the languages that are selected in this view
    @Binding var selectedLanguages: [Language]
    ///the record  holding the data for this cell
    let language: LanguageRecord
    ///determines if the languages is already known from another source
    let isKnown: Bool
    ///the total selections that can be made in this view
    let maxSelections: Int
    ///the number of selections made in this view
    var selectionsMade: Int { return selectedLanguages.count }
        
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: isSelected || isKnown ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(Color.App.primary)
                Text(language.name.capitalized)
                    .foregroundColor(isKnown ? Color.gray : Color.black)
                Spacer()
                if isKnown {
                    VStack {
                    Spacer()
                    Text("(already known)")
//                    Text("(known by all \(dwarves)")
                    .font(.caption)
                    .foregroundColor(Color.gray)
                    }
                }
            }
        }
        .listRowBackground(isSelected || isKnown ? Color.App.surface : Color.white)
        .onTapGesture {
            if !isKnown {
                toggleSelect()
            }
        }
    }
    
    init(for language: LanguageRecord, selectedLanguages: Binding<[Language]>, isSelected: Bool, isKnown: Bool, maxSelections: Int) {
        self.language           = language
        self.isKnown            = isKnown
        self.maxSelections      = maxSelections
        
        
        self._isSelected        = State(initialValue: isSelected)
        self._selectedLanguages = selectedLanguages
    }

    func toggleSelect() {
        if isSelected {
            ///remove selection
            guard let index = selectedLanguages.firstIndex(where: { $0.name == language.name }) else { return }
            selectedLanguages.remove(at: index)
        }
        
        if !isSelected {
            ///is selection possible
            guard selectionsMade < maxSelections else { return }

            ///add selection
            selectedLanguages.append(
                Language(name: language.name, isSelectable: true, source: .race))
        }
        
        isSelected = !isSelected
    }
}

struct LanguageSelectionView_Previews: PreviewProvider {
    @State static var selected = [
        Language(name: "abyssal", isSelectable: true, source: .race),
        Language(name: "goblin", isSelectable: true, source: .race)]
    @State static var known = [
        Language(name: "common", isSelectable: false, source: .race),
        Language(name: "thieves' cant", isSelectable: false, source: .class)
    ]

    static var previews: some View {
        LanguageSelectionView(known: known, selected: $selected)
    }
}
