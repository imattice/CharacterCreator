//
//  RaceSelectionView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/18/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

struct RaceSelectionView: View {
    let allRecords = RaceRecord.all()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allRecords) { record in
                    NavigationLink(record.name, destination: RaceDetailView(race: record))
                    HStack {
                        Image(record.name)
                            .resizable()
                            .frame(width: 70.0, height: 70.0)
                        VStack {
                            Text(record.name.capitalized)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("Choose a Race")
        }
    }
}

struct RaceSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RaceSelectionView()
    }
}
