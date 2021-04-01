//
//  SelectionButton.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 12/28/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

///a button to use when selecting an option
struct SelectionButton: View {
    var body: some View {
        Button(action: {
            print("hi")
        }, label: {
            Text("Select")
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.App.primary)
                .cornerRadius(10)
                .foregroundColor(.white)
                .padding()
        })
    }
}


struct SelectionButton_Previews: PreviewProvider {
    static var previews: some View {
        SelectionButton()
    }
}
