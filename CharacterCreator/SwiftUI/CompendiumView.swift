//
//  CompendiumView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/13/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import SwiftUI

struct CompendiumView: View {
    var body: some View {
        AttributedText(text: "Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.\\nThe spell damages objects in the area and ignites flammable objects that aren’t being worn or carried.")
    }
}

struct CompendiumView_Previews: PreviewProvider {
    static var previews: some View {
        CompendiumView()
    }
}
