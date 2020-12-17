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
    @State var title: String
    @State var description: String
    @State var selections: [String] = [String]()
    @State var selection: String?
    @State var selectionListViewIsShown: Bool = false

    var body: some View {
        HStack {
            NavigationLink(
                destination: SelectionListView(selections: selections,
                                               selection: $selection),
//                                               selectionListViewIsShown: $selectionListViewIsShown),
                isActive: $selectionListViewIsShown,
                label: {
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(Font.App.header)
                    Text(description)
                        .font(Font.App.caption)
                        .lineLimit(nil)
                    if !selections.isEmpty {
                        Divider()
                        Text("Selected:")
                            .font(.headline)
//                            .font(Font.App.headline)
                        Text(selection?.capitalized ?? "None")
                            .foregroundColor(Color.App.primary)
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
    
//    func selection<T>() -> T {
//
//    }
}

struct SelectionListView: View {
    @State var selections: [String]
    @Binding var selection: String?
//    @Binding var selectionListViewIsShown: Bool
    
//    @State var onCancel: () -> ()
//    @State var onSelect: () -> ()

//    let originalSelection = selection
    
    var body: some View {
        List {
            ForEach(selections, id: \.self) { title in
                HStack {
                    SelectionCell(title: title, selection: $selection)
                }
                .onTapGesture {
                    toggleSelect()
                }
            }
        }
//        .navigationBarItems(leading:
//                                Text("Cancel")
//                                .onTapGesture { cancel() },
//                            trailing: Text("Select")
//                                .onTapGesture { select() })
    }
        
    func toggleSelect() {
        
    }
    func cancel() {
        
    }
    func select() {
        
    }
}

struct SelectionCell: View {
    @State var title: String
    @State var description: String? = nil
    @Binding var selection: String?
    var isSelected: Bool { title == selection }
    
    var body: some View {
        HStack {
            isSelected ? Image(systemName: "checkmark.circle.fill") : Image(systemName: "circle")
            Text(title.capitalized)
            if let description = description {
                Text(description)
            }
        }
        .onTapGesture {
            selection = title
        }
    }
}
    
    
struct SelectionView_Previews: PreviewProvider {
    static var previews: some View {
        //Selection
        Group {
            NavigationView {
            SelectablePanel(title: "Sample", description: "This is a sample of the Panel with many words and details on how a selectable panel may look like.", selections: ["smith's tools", "brewer's supplies", "mason's tools"])
            }
//                .previewLayout(.sizeThatFits)
//
//            SelectionListView(selections: ["smith's tools", "brewer's supplies", "mason's tools"], selection: .constant(""))
        }
        .previewLayout(.sizeThatFits)
    }
}
