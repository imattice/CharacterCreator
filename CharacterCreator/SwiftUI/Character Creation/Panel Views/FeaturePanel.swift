//
//  FeaturePanel.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 12/28/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

///a panel view for showing details for a given feature
struct FeaturePanel: View {
    let feature: Feature
    var body: some View {
        VStack(alignment: .leading) {
            Text(feature.title)
                .font(.subheadline)
                .bold()
                .padding(.bottom, 1)
            Text(feature.description)
                .font(Font.App.body)
                .lineLimit(nil)
//                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
        }
        .layoutPriority(5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color.App.surface)
        .foregroundColor(.black )
        .cornerRadius(10)
    }
    
    init(_ feature: Feature) {
        self.feature = feature
    }
}

///a view showing multiple features in a vstack
struct FeatureStack: View {
    var title: String?
    @State var features: [Feature]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let title = title {
                Text("\(title.capitalized) Features")
                    .font(.title)
            }
            ForEach(features) { feature in
                if let selectableFeature = feature as? SelectableFeature {
                    SelectableFeaturePanel()
                        .environmentObject(selectableFeature)            }
                else {
                    FeaturePanel(feature)
                }

            }
        }
        .layoutPriority(3)
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    init(title: String? = nil, _ features: [Feature]) {
        self.title = title
        self._features = State(initialValue: features)
    }
}

struct FeaturePanel_Previews: PreviewProvider {
    static var previews: some View {
        FeaturePanel(Feature(title: "Sample Feature", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vel turpis nunc eget lorem dolor sed viverra. Odio pellentesque diam volutpat commodo sed egestas. Adipiscing diam donec adipiscing tristique risus nec feugiat.", origin: .race))
    }
}
