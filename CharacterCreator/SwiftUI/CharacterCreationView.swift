//
//  CharacterCreationView.swift
//  Source
//
//  Created by Ike Mattice on 3/24/21.
//

import SwiftUI

struct CharacterCreationView: View {
    var body: some View {
        HStack {
            StepPanelView()
            Spacer()
        }
    }
}

struct CharacterCreationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        CharacterCreationView()
            .previewDevice("iPad mini 4")
            .previewLayout(PreviewLayout.Landscape.mini)
        CharacterCreationView()
            .previewDevice("iPad Pro (10.5-inch)")
            .previewLayout(PreviewLayout.Landscape.pro)
        CharacterCreationView()
            .previewDevice("iPad Pro (12.9-inch) (2nd generation)")
            .previewLayout(PreviewLayout.Landscape.largePro)
        }
    }
}
