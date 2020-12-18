//
//  SelectionView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 12/16/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

///for displaying options with a singular selection
struct SelectablePanel: View {
    @EnvironmentObject var feature: SelectableFeature
    ///tracks if the list view is shown
    @State var selectionListViewIsShown: Bool = false

    var body: some View {
        HStack {
            NavigationLink(destination:
                            StandardSelectionListView(shown: $selectionListViewIsShown,
                                                       selection: feature.selection)
                    .environmentObject(feature),
                isActive: $selectionListViewIsShown,
                label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(feature.title)
                                .font(Font.App.header)
                            Text(feature.description)
                                .font(Font.App.caption)
                                .lineLimit(nil)
                            
                            ///display the selected feature, if any
                            if !feature.options.isEmpty {
                                Divider()
                                Text("Selected:")
                                    .font(Font.App.headline)
                                Text(feature.selection?.capitalized ?? "None")
                                    .foregroundColor(Color.App.primary)
                            }
                        }
                        ///indicate that a selection can be made in another view, if there are options
                        if !feature.options.isEmpty {
                            Image(systemName: "chevron.right")
                        }
                    }
                .foregroundColor(.black)
                Spacer()
            })
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.App.surface)
        .cornerRadius(10)
    }
}

///provides a selection list for simple strings
struct StandardSelectionListView: View {
    @EnvironmentObject var feature: SelectableFeature
    
    ///tracks if this view is shown
    @Binding var shown: Bool
    ///holds the selections made in the ui and sets them to the environment object once the view is dismissed
    @State var selection: String?
    
    var body: some View {
        List {
            ForEach(feature.options, id: \.self) { option in
                HStack {
                    SelectionCell(title: option, selection: $selection)
                }
            }
        }
        .navigationBarItems(leading:
                                Button(action:  { cancel()          },
                                       label:   { Text("Cancel")    }),
                            trailing:
                                Button(action:  { select()          },
                                       label:   { Text("Select")    }))
        .navigationBarBackButtonHidden(true)
    }
    
    func cancel() {
        feature.selection = nil

        self.shown = false
    }
    func select() {
        feature.selection = selection
        self.shown = false
    }
}

struct SelectionCell: View {
    ///the title for the option
    @State var title: String
    ///a binding to the current selection
    @Binding var selection: String?
    ///tracks if this cell is currently selected
    var isSelected: Bool { title == selection }
    
    var body: some View {
        HStack {
            isSelected ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "circle")
            Text(title.capitalized)
        }
        .onTapGesture {
            selection = title
        }
    }
}
    
    
struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                SelectablePanel()
                    .environmentObject(SelectableFeature(title: "Sample", description: "This is a sample of the Panel with many words and details on how a selectable panel may look like.", origin: .race, options: ["smith's tools", "brewer's supplies", "mason's tools"]))
                SelectablePanel()
                    .environmentObject(SelectableFeature(title: "Empty Sample", description: "More description", origin: .race, options: [String]()))
            }
        }
        .previewLayout(.sizeThatFits)
    }
}
