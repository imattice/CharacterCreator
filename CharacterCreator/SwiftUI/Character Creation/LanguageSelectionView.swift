//
//  LanguageSelectionView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/3/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct LanguageSelectionView: View {
    @Binding var selectedLanguages: [Language]
    
    var knownLanguages: [String]
    let common: [LanguageRecord]
    let exotic: [LanguageRecord]
    let maxSelections: Int
    var selectionsMade: Int { return selectedLanguages.count }
    
    var body: some View {
        List {
            Section(header: Text("Common Languages")) {
                ForEach(common) { language in
                    LanguageCell(language: language, selected: false, selectedLanguages: $selectedLanguages, maxSelections: maxSelections)
                }
            }
//            Section(header: Text("Exotic Languages")) {
//                ForEach(exotic) { language in
//                    LanguageCell(language: language, selectedLanguages: $selectedLanguages, maxSelections: maxSelections)
//
//                }
//            }
        }
    }
    
    init(known: [String], selected: Binding<[Language]>, maxSelections: Int = 1) {
        let languages = LanguageRecord.all().filter { $0.isSecret == false }
        self.common = languages.filter { $0.isExotic == false }
        self.exotic = languages.filter { $0.isExotic == true }
        self.maxSelections = maxSelections
        self.knownLanguages = known

//        self._knownLanguages = State(wrappedValue: known)
        self._selectedLanguages = selected
    }
}



struct LanguageCell: View {
    let language: LanguageRecord
    
    @State var selected: Bool
    @Binding var selectedLanguages: [Language]
    
    let maxSelections: Int
    var selectionsMade: Int { return selectedLanguages.count }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
            Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(Color.App.primary)
            Text(language.name.capitalized)
            }
        }
        .listRowBackground(selected ? Color.App.surface : Color.white)
        .onTapGesture {
            toggleSelect()
        }
        

        
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
    
    func toggleSelect() {
//            guard selectionsMade < maxSelections else { return }
        selected = !selected
        
        if selected {
            selectedLanguages.append(
                Language(name: language.name, isSelectable: true, source: .race))
            dump(selectedLanguages)
        }
        //            else {
        //                guard let index = selectedLanguages.firstIndex(where: { $0.name == language.name }) else { return }
        //                selectedLanguages.remove(at: index)
        //            }
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
