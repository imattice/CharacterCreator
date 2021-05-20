//
//  AttributedText.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/16/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import SwiftUI

//TODO: - ✅ Handle new lines of text
//TODO: - ✅ Add additional space between new lines
//TODO: - ✅ Die should be bold (1d4)
//TODO: - ✅ Damage types should be bold and colored (1d4 acid damage)
//TODO: - Use some kind of markdown to represent a table
//TODO: - Display table as part of string (probably as a separate UI view)
//TODO: - Display titled paragraphs
//TODO: - Display bulleted lists

struct AttributedText: View {
    let text: String
    var splitText: [String] {
    text.components(separatedBy: .newlines)
      .filter { !$0.isEmpty }
  }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(splitText, id: \.self) { text in
            AttributedTextView(text: text)
                .lineSpacing(4)
                .padding(.top, 4)
            }
        }
        .padding()
    }
    
    private
    func AttributedTextView(text: String) -> Text {
        enum Rules: String, CaseIterable {
            case die = "[0-9]+d[0-9]+"
            case damage = "(acid|fire|cold|thunder|lightning|poison|necrotic|radient|force|bludgeoning|piercing|slashing) damage"
            case savingThrow = "(Strength|Constitution|Dexterity|Charisma|Wisdom|Intelligence) saving throw"
            
            static
            func all() -> String {
                return Rules.allCases.map { $0.rawValue }.joined(separator: "|")
            }
            
            static
            func match(_ text:String) -> Rules? {
                if text.matches(Rules.die.rawValue) {
                    return die
                }
                else if text.matches(Rules.damage.rawValue) {
                    return damage
                }
                else if text.matches(Rules.savingThrow.rawValue) {
                    return savingThrow
                }
                return nil
            }
        }
    
        if let range = text.range(of: Rules.all(), options: .regularExpression) {
            print("match: \(String(text[range]))")
            
            let attributedView: Text = {
                switch Rules.match(String(text[range])) {
                case .die:
                    return StyledText(String(text[range]), color: .black)
                case .damage:
                    return StyledText(String(text[range]), color: .blue)
                case .savingThrow:
                    return StyledText(String(text[range]), color: .red)
                default: return Text(String(text[range]))
                }
            }()
            
            return
                Text(text[text.startIndex..<range.lowerBound]) +
                attributedView +
                AttributedTextView(text: String(text[range.upperBound..<text.endIndex]))
        }
        else {
            return Text(text)
        }
    }
    

//MARK: - SubViews
    private
    func StyledText(_ text: String, color: Color = .blue) -> Text {
        return Text(text.capitalized)
            .bold()
            .font(.system(size: 18))
            .foregroundColor(color)
    }
}

struct TitledParagraphView: View {
    let title: String
    let paragraph: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .bold()
                .padding(.bottom, 4)
            AttributedText(text: paragraph)
        }
        .padding(8)
    }
}

///Contains data that can be displayed in a Data Table View
struct JSONTable: Codable {
    /// The display title of the table
    let title: String
    /// The headers of the columns of the tables
    let headers: [String]
    /// The data for the individual rows of the table, where each array is a new row, and each row contains a number of strings representing the item in the table
    let rows: [[String]]
    /// A unique identifier used to position the table within a Text view
    let tag: String?
    
    
//    let json =     """
//    {
//        "title": "Animated Object Statistics",
//        "headers": ["Size", "HP", "AC", "Attack", "Str", "Dex"],
//        "rows": [
//            ["Tiny", "20", "18", "+8 to hit, 1d4+4 damage", "4", "8"],
//            ["Small", "25", "16", "+6 to hit, 1d8+2 damage", "6", "14"],
//            ["Medium", "40", "13", "+5 to hit, 2d6+1 damage", "10", "12"],
//            ["Large", "50", "10", "+6 to hit, 2d10+2 damage", "14", "10"],
//            ["Huge", "80", "10", "+8 to hit, 2d12 + 4 damage", "18", "6"]
//        ],
//        "tag": 1
//    }
//    """
}


/// A view that displays content in a data table format
struct DataTableView: View {
    let table: JSONTable
    let headerBackgroundColor: Color
    let altRowColor: Color
    
    var body: some View {
        VStack {
            LazyVGrid(columns:
                        Array(repeating:
                                GridItem(.flexible(), spacing: 0, alignment: .center),
                              count: table.headers.count),
                      alignment: .center,
                      spacing: nil,
                      pinnedViews: [.sectionHeaders]) {
                
                Section(header:
                    //Table Title
                            TableTitle(table.title)) {
                    
                    //Table Headers
                        ForEach(table.headers, id: \.self) { header in
                            TableHeader(header)
                        }
                        .background(headerBackgroundColor
                                        .opacity(0.9))
                    
                    //Table Content
                    ForEach(table.rows.indices, id: \.self) { rowIndex in
                        let row = table.rows[rowIndex]
                            
                        TableRow(row)
                            .background(rowIndex % 2 == 0 ? .clear : altRowColor.opacity(0.5))
                    }
                }
            }
            .border(Color.black)
        }
    }
    
    init(table: JSONTable, headerColor: Color = Color(hex: "#D0CEBA"), altRowColor: Color = Color(hex: "#E3E8E9")) {
        self.table = table
        self.headerBackgroundColor = headerColor
        self.altRowColor = altRowColor
    }
    
    /// A view that displays title of the table
    private
    struct TableTitle: View {
        let title: String
        
        var body: some View {
            Text(title)
                .bold()
                .font(.title)
                .padding()
        }
        
        init(_ title: String) {
            self.title = title
        }
    }

    ///A view that displays the column headers for the content
    private
    struct TableHeader: View {
        let header: String
        
        var body: some View {
            Text(header)
                .bold()
                .padding()
                .font(.subheadline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        init(_ header: String) {
            self.header = header
        }
    }
    
    ///A view that displays the content in a row
    private
    struct TableRow: View {
        let rowData: [String]
        
        var body: some View {
            ForEach(rowData.indices) { index in
                Text(rowData[index])
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
        init(_ data: [String]) {
            self.rowData = data
        }
    }
}


struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AttributedText(text: "Blazing orbs of fire plummet to the ground at four different points you can see within range. Each creature in a 40-foot-radius sphere centered on each point you choose must make a Dexterity saving throw. The sphere spreads around corners. A creature takes 20d6 fire damage and 20d6 bludgeoning damage on a failed save, or half as much damage on a successful one. A creature in the area of more than one fiery burst is affected only once.\nThe spell damages objects in the area and ignites flammable objects that aren’t being worn or carried.")
            .previewLayout(.sizeThatFits)
            
            AttributedText(text: "You utter a divine word, imbued with the power that shaped the world at the dawn of creation. Choose any number of creatures you can see within range. Each creature that can hear you must make a Charisma saving throw. On a failed save, a creature suffers an effect based on its current hit points:\n• 50 hit points or fewer: deafened for 1 minute\n• 40 hit points or fewer: deafened and blinded for 10 minutes\n• 30 hit points or fewer: blinded, deafened, and stunned for 1 hour\n• 20 hit points or fewer: killed instantly\nRegardless of its current hit points, a celestial, an elemental, a fey, or a fiend that fails its save is forced back to its plane of origin (if it isn’t there already) and can’t return to your current plane for 24 hours by any means short of a wish spell.")
                .previewLayout(.sizeThatFits)
            
            DataTableView(table: JSONTable(
                            title: "Animated Object Statistics",
                            headers: ["Size", "HP", "AC", "Attack", "STR", "DEX"],
                            rows: [
                                ["Tiny", "20", "18", "+8 to hit,\n1d4+4 damage", "4", "8"],
                                ["Small", "25", "16", "+6 to hit,\n1d8+2 damage", "6", "14"],
                                ["Medium", "40", "13", "+5 to hit,\n2d6+1 damage", "10", "12"],
                                ["Large", "50", "10", "+6 to hit,\n2d10+2 damage", "14", "10"],
                                ["Huge", "80", "10", "+8 to hit,\n2d12 + 4 damage", "18", "6"]
                            ], tag: nil ))
                .previewLayout(.fixed(width: 700, height: 700))
        }
        Group {
            VStack(alignment: .leading) {
            TitledParagraphView(title: "1. Red.", paragraph: "The target takes 10d6 fire damage on a failed save, or half as much damage on a successful one.")
            TitledParagraphView(title: "2. Orange.", paragraph: "The target takes 10d6 acid damage on a failed save, or half as much damage on a successful one.")
                
            TitledParagraphView(title: "3. Yellow.", paragraph: "The target takes 10d6 lightning damage on a failed save, or half as much damage on a successful one.")
            TitledParagraphView(title: "4. Green.", paragraph: "The target takes 10d6 poison damage on a failed save, or half as much damage on a successful one.")
            TitledParagraphView(title: "5. Blue.", paragraph: "The target takes 10d6 cold damage on a failed save, or half as much damage on a successful one.")
            TitledParagraphView(title: "6. Indigo.", paragraph: "On a failed save, the target is restrained. It must then make a Constitution saving throw at the end of each of its turns. If it successfully saves three times, the spell ends. If it fails its save three times, it permanently turns to stone and is subjected to the petrified condition. The successes and failures don’t need to be consecutive; keep track of both until the target collects three of a kind.")
            TitledParagraphView(title: "7. Violet.", paragraph: "On a failed save, the target is blinded. It must then make a Wisdom saving throw at the start of your next turn. A successful save ends the blindness. If it fails that save, the creature is transported to another plane of existence of the GM’s choosing and is no longer blinded. (Typically, a creature that is on a plane that isn’t its home plane is banished home, while other creatures are usually cast into the Astral or Ethereal planes.)")
            TitledParagraphView(title: "8. Special.", paragraph: "The target is struck by two rays. Roll twice more, rerolling any 8.")
            }
            .previewLayout(.sizeThatFits)
        }
        
    }
    
    //Last Test
//    This spell instantly transports you and up to eight willing creatures of your choice that you can see within range, or a single object that you can see within range, to a destination you select. If you target an object, it must be able to fit entirely inside a 10-foot cube, and it can’t be held or carried by an unwilling creature.\nThe destination you choose must be known to you, and it must be on the same plane of existence as you. Your familiarity with the destination determines whether you arrive there successfully. The GM rolls d100 and consults the table.\n<INSERT TABLE HERE>\nFamiliarity. “Permanent circle” means a permanent teleportation circle whose sigil sequence you know. “Associated object” means that you possess an object taken from the desired destination within the last six months, such as a book from a wizard’s library, bed linen from a royal suite, or a chunk of marble from a lich’s secret tomb.\n“Very familiar” is a place you have been very often, a place you have carefully studied, or a place you can see when you cast the spell. “Seen casually” is someplace you have seen more than once but with which you aren’t very familiar. “Viewed once” is a place you have seen once, possibly using magic. “Description” is a place whose location and appearance you know through someone else’s description, perhaps from a map.\n“False destination” is a place that doesn’t exist. Perhaps you tried to scry an enemy’s sanctum but instead viewed an illusion, or you are attempting to teleport to a familiar location that no longer exists.\nOn Target. You and your group (or the target object) appear where you want to.\nOff Target. You and your group (or the target object) appear a random distance away from the destination in a random direction. Distance off target is 1d10 × 1d10 percent of the distance that was to be traveled. For example, if you tried to travel 120 miles, landed off target, and rolled a 5 and 3 on the two d10s, then you would be off target by 15 percent, or 18 miles. The GM determines the direction off target randomly by rolling a d8 and designating 1 as north, 2 as northeast, 3 as east, and so on around the points of the compass. If you were teleporting to a coastal city and wound up 18 miles out at sea, you could be in trouble.\nSimilar Area. You and your group (or the target object) wind up in a different area that’s visually or thematically similar to the target area. If you are heading for your home laboratory, for example, you might wind up in another wizard’s laboratory or in an alchemical supply shop that has many of the same tools and implements as your laboratory. Generally, you appear in the closest similar place, but since the spell has no range limit, you could conceivably wind up anywhere on the plane.\nMishap. The spell’s unpredictable magic results in a difficult journey. Each teleporting creature (or the target object) takes 3d10 force damage, and the GM rerolls on the table to see where you wind up (multiple mishaps can occur, dealing damage each time).
}

