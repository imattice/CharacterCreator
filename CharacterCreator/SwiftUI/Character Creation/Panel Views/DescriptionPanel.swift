//
//  DescriptionPanel.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 12/28/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

///a panel view for showing a body of text
struct DescriptionPanel: View {
    let description: String
    var body: some View {
        Text(description)
            .padding()
            .font(Font.App.body)
            .foregroundColor(.black )
            .background(Color.App.surface)
            .cornerRadius(10)
            .frame(maxWidth: .infinity)

    }
    init(_ description: String) {
        self.description = description
    }
}

struct DescriptionPanel_Previews: PreviewProvider {
    static var previews: some View {
        //Description for Halfling race
        DescriptionPanel("A comfortable home and the happiness of friends are what most halflings desire.  They tend to avoid the adventuring life, though some are willing to ignore the expectation of the domestic life to see the world.")
    }
}
