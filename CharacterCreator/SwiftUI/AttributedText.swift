//
//  AttributedText.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/16/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import SwiftUI

//TODO: - Handle new lines of text
//TODO: - Die should be bold (1d4)
//TODO: - Damage types should be bold and colored (1d4 acid damage)
//TODO: - Use some kind of markdown to represent a table
//TODO: - Display table as part of string (probably as a separate UI view)
//TODO: - Display titled paragraphs

struct AttributedText: View {
    @State var text: String
    
    var body: some View {
        AttributedTextView(text: text)
    }
    
   // @ViewBuilder
    private func AttributedTextView(text: String) -> Text {
        if let range = text.range(of: "[0-9]+d[0-9]+", options: .regularExpression) {
            return
        //The unattributed text
        Text(text[text.startIndex..<range.lowerBound]) +
            
            //Append the attributed text
                DieTextView(String(text[range])) +
            
            //Search for additional instances of text that needs attribution
                AttributedTextView(text: String(text[range.upperBound..<text.endIndex]))
        
        } else {
            //If the searched text is not found, add the rest of the string to the end
            return Text(text)
        }
    }
    
    private
    func DieTextView(_ text: String) -> Text {
        return Text(text)
            .bold()
    }
    
    
    

    
    
//    init(_ text: String) {
//        self._text = State(initialValue: text)
//    }
}

struct DieTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .bold()
    }
}


struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText(text: "Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.\\nThe spell damages objects in the area and ignites flammable objects that aren’t being worn or carried.")
            .previewLayout(.sizeThatFits)
    }
}
