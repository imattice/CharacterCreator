//
//  AttributedText.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/16/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import SwiftUI

/**
 Formats and displays text
 
 Supports formatting in the following formats
 
 - multiple paragraphs: Adds space before text separated by \n
 - titled paragraphs: Applies bold formatting to up to the first number of characters of a paragraph, ending with a period
 - bulleted lists: Indent paragraphs that start with a "•"
 - hyphenated lists: Indents paragraphs that start with "-".  indents further than the bulleted list
 - data table: Inserts a data table with a table id associated with a table in tables.json
 
 */
struct AttributedText: View {
    let text: String
    var splitText: [String] { text.components(separatedBy: .newlines).filter { !$0.isEmpty } }
    let titleLength: Int = 12

    
    var body: some View {
        VStack(alignment: .leading) {
            //Split the text string by new lines and add formatting to each paragraphs
            ForEach(splitText, id: \.self) { paragraph in
                
                //MARK: Titled Paragraph
                if let range = paragraph.range(of: RegexRules.paragraphTitle.rawValue, options: .regularExpression),
                   let title = String(paragraph[range]),
                   let paragraph = String(paragraph[range.upperBound..<paragraph.endIndex]){
                    Group {
                        TitleText(text: title) +
                            AttributedTextView(text: paragraph)
                    }
                    .padding(EdgeInsets(top: 4, leading: 20, bottom: 0, trailing: 0))
                }
                
                //MARK: Bulleted List
                else
                if paragraph.first == "•" {
                    AttributedTextView(text: paragraph)
                        .padding(EdgeInsets(top: 4, leading: 20, bottom: 0, trailing: 0))
                }
                
                //MARK: Hyphenated List
                else if paragraph.first == "-" {
                    AttributedTextView(text: paragraph)
                        .padding(EdgeInsets(top: 4, leading: 35, bottom: 0, trailing: 0))
                }
                
                //MARK: Data Table
                else if paragraph.matches(RegexRules.dataTable.rawValue),
                        let tableID = paragraph.dropFirst(6) {
                    DataTableView(id: String(tableID))
                        .padding()
                }
                //MARK: Unformatted paragraph
                else {
                    AttributedTextView(text: paragraph)
                        .lineSpacing(4)
                        .padding(.top, 4)
                }
            }
        }
        .padding()
    }
    
    ///Returns formatted SwiftUI Text view based on formatting rules for die rolls, damage types, and saving throws
    private
    func AttributedTextView(text: String) -> Text {
        ///The text color for strings representing dice rolls
        let dieColor: Color = .black
        ///The text color for strings representing damage types
        let damageColor: Color = .black
        ///The text color for strings represeting saving throws
        let savingThrowColor: Color = .black
        
        let rules = "\(RegexRules.die.rawValue)|\(RegexRules.damage.rawValue)|\(RegexRules.savingThrow.rawValue)"
    
        //Check if the text contains a string describing a die, damage type, or saving throw
        if let range = text.range(of: rules, options: .regularExpression) {
            
            //return a styled text view based on the matched text
            let attributedView: Text = {
                let text = String(text[range])
                switch RegexRules.match(text) {
                case .die:
                    return StyledText(text, color: dieColor)
                case .damage:
                    return StyledText(text, color: damageColor)
                case .savingThrow:
                    return StyledText(text, color: savingThrowColor)
                default: return Text(text)
                }
            }()
            
            //recurively look through the string and add formatting to any parts that match
            return
                Text(text[text.startIndex..<range.lowerBound]) +
                attributedView +
                AttributedTextView(text: String(text[range.upperBound..<text.endIndex]))
        }
        
        //If there are no matches, just return a basic Text view
        else {
            return Text(text)
        }
    }
    

//MARK: - SubViews
    ///A Text view that is bold, colored, and larger than basic text
    private
    func StyledText(_ text: String, color: Color = .blue) -> Text {
        return Text(text.capitalized)
            .bold()
            .font(.system(size: 18))
            .foregroundColor(color)
    }
    
    ///A Text view that is bold and larger than basic text
    private
    func TitleText(text: String) -> Text {
        return
            Text(text)
            .font(.title3)
            .bold()
    }
}


struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AttributedText(text: "Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.\nThe spell damages objects in the area and ignites flammable objects that aren’t being worn or carried.")
                .previewDisplayName("Dice Roll and Saving Throw Formatting")
            
            AttributedText(text: "You utter a divine word, imbued with the power that shaped the world at the dawn of creation. Choose any number of creatures you can see within range. Each creature that can hear you must make a Charisma saving throw. On a failed save, a creature suffers an effect based on its current hit points:\n• 50 hit points or fewer: deafened for 1 minute\n• 40 hit points or fewer: deafened and blinded for 10 minutes\n• 30 hit points or fewer: blinded, deafened, and stunned for 1 hour\n• 20 hit points or fewer: killed instantly\nRegardless of its current hit points, a celestial, an elemental, a fey, or a fiend that fails its save is forced back to its plane of origin (if it isn’t there already) and can’t return to your current plane for 24 hours by any means short of a wish spell.")
                .previewDisplayName("Bulleted Spell")
        
            AttributedText(text: "Eight multicolored rays of light flash from your hand. Each ray is a different color and has a different power and purpose. Each creature in a 60-foot cone must make a Dexterity saving throw. For each target, roll a d8 to determine which color ray affects it.\n1. Red. The target takes 10d6 fire damage on a failed save, or half as much damage on a successful one.\n2. Orange. The target takes 10d6 acid damage on a failed save, or half as much damage on a successful one.\n3. Yellow. The target takes 10d6 lightning damage on a failed save, or half as much damage on a successful one.\n4. Green. The target takes 10d6 poison damage on a failed save, or half as much damage on a successful one.\n5. Blue. The target takes 10d6 cold damage on a failed save, or half as much damage on a successful one.\n60. Indigo. On a failed save, the target is restrained. It must then make a Constitution saving throw at the end of each of its turns. If it successfully saves three times, the spell ends. If it fails its save three times, it permanently turns to stone and is subjected to the petrified condition. The successes and failures don’t need to be consecutive; keep track of both until the target collects three of a kind.\n7. Violet. On a failed save, the target is blinded. It must then make a Wisdom saving throw at the start of your next turn. A successful save ends the blindness. If it fails that save, the creature is transported to another plane of existence of the GM’s choosing and is no longer blinded. (Typically, a creature that is on a plane that isn’t its home plane is banished home, while other creatures are usually cast into the Astral or Ethereal planes.)\n8. Special. The target is struck by two rays. Roll twice more, rerolling any 8.")
                .previewDisplayName("Titled Paragraph Formatting")
            
            AttributedText(text: "You pull wisps of shadow material from the Shadowfell to create a nonliving object of vegetable matter within range: soft goods, rope, wood, or something similar. You can also use this spell to create mineral objects such as stone, crystal, or metal. The object created must be no larger than a 5- foot cube, and the object must be of a form and material that you have seen before.\nThe duration depends on the object’s material. If the object is composed of multiple materials, use the shortest duration.\nTABLE:spell_creation\nUsing any material created by this spell as another spell’s material component causes that spell to fail.")
                .previewDisplayName("Data Table Integration")
            
            AttributedText(text: "This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can’t be held or carried by an unwilling creature.\nThe destination you choose must be known to you, and it must be on the same plane of existence as you. Your familiarity with the destination determines whether you arrive there successfully. The GM rolls d100 and consults the table.\nTABLE:spell_teleportation_accuracy\nFamiliarity. “Permanent circle” means a permanent teleportation circle whose sigil sequence you know. “Associated object” means that you possess an object taken from the desired destination within the last six months, such as a book from a wizard’s library, bed linen from a royal suite, or a chunk of marble from a lich’s secret tomb.\n-“Very familiar” is a place you have been very often, a place you have carefully studied, or a place you can see when you cast the spell. \n-“Seen casually” is someplace you have seen more than once but with which you aren’t very familiar. \n-“Viewed once” is a place you have seen once, possibly using magic. \n-“Description” is a place whose location and appearance you know through someone else’s description, perhaps from a map.\n-“False destination” is a place that doesn’t exist. Perhaps you tried to scry an enemy’s sanctum but instead viewed an illusion, or you are attempting to teleport to a familiar location that no longer exists.\nOn Target. You and your group (or the target object) appear where you want to.\nOff Target. You and your group (or the target object) appear a random distance away from the destination in a random direction. Distance off target is 1d10 × 1d10 percent of the distance that was to be traveled. For example, if you tried to travel 120 miles, landed off target, and rolled a 5 and 3 on the two d10s, then you would be off target by 15 percent, or 18 miles. The GM determines the direction off target randomly by rolling a d8 and designating 1 as north, 2 as northeast, 3 as east, and so on around the points of the compass. If you were teleporting to a coastal city and wound up 18 miles out at sea, you could be in trouble.\nSimilar Area. You and your group (or the target object) wind up in a different area that’s visually or thematically similar to the target area. If you are heading for your home laboratory, for example, you might wind up in another wizard’s laboratory or in an alchemical supply shop that has many of the same tools and implements as your laboratory. Generally, you appear in the closest similar place, but since the spell has no range limit, you could conceivably wind up anywhere on the plane.\nMishap. The spell’s unpredictable magic results in a difficult journey. Each teleporting creature (or the target object) takes 3d10 force damage, and the GM rerolls on the table to see where you wind up (multiple mishaps can occur, dealing damage each time).")
                .previewDisplayName("All Formatting Example")
        }
        .previewLayout(.sizeThatFits)

    }
}

