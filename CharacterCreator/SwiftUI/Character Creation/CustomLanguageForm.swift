//
//  CustomLanguageForm.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/9/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct CustomLanguageForm: View {
    ///the name of the language
    @State var name: String = ""
    ///a  paragraph containing descriptive details about the language
    @State var description: String = ""
    ///describes who typically speaks this language
    @State var spokenBy: String = ""
    ///the script that is used to write this language
    @State var script: String = "none"
    ///determines if the language is rare
    @State var isExotic: Bool = false
    ///determines if the language is only know by specific groups
    @State var isSecret: Bool = false
    
    @State var selectedScript: String?
    var scriptOptions: [String] = {
        var result = LanguageRecord.scripts
        result.append("custom")
        return result
    }()
    
        
    
    var body: some View {
        NavigationView {
        Form {
            TextField("Language Name", text: $name)
            
            Section {
                TextField("Description", text: $description)
                Text("What does the language sound like? Is it inspired by other languages?")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            
            Section {
                TextField("Spoken By", text: $description)
                Text("Which groups speak this language regularly?")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            
            
            Section {
                Picker(selection: $selectedScript,
                       label: Text("Script")) {
                    ForEach(scriptOptions, id: \.self) { script in
                        Text(script.capitalized).tag(script)
                    }
                    .navigationTitle("Script")
                }
                if selectedScript == "custom" {
                    TextField("Script Name", text: $description)
                    Text("Does this language use an existing script? What does the writing of this language look like?")
                        .font(.caption)
                        .foregroundColor(Color.gray)
                }
            }

            Section {
                Toggle(isOn: $isExotic) {
                    Text("Exotic Language")
                }
                Text("This language is spoken by specific remote groups and is not regularly taught or spoken outside of those groups")
                    .font(.caption)
                    .foregroundColor(Color.gray)
            }
            Section{
                Toggle(isOn: $isSecret) {
                    Text("Secret Language")
                }
                Text("This language is only spoken by a very small group of individuals and is unkown the the rest of the world.")
                    .font(.caption)
                    .foregroundColor(Color.gray)

            }
            
            Section {
                Button(action: {
//                    LanguageRecord.saveCustom(
//                    )
                }) {
                    Text("Save")
                }
            }
        }
        .navigationTitle("Custom Language")
//        .background(Color.App.background)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct CustomLanguageForm_Previews: PreviewProvider {
    static var previews: some View {
        CustomLanguageForm()
    }
}
