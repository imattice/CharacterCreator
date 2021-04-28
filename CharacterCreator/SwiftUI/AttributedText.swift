//
//  AttributedText.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/16/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import SwiftUI

//TODO: - ✅ Handle new lines of text
//TODO: - Add additional space between new lines
//TODO: - ✅ Die should be bold (1d4)
//TODO: - ✅ Damage types should be bold and colored (1d4 acid damage)
//TODO: - Use some kind of markdown to represent a table
//TODO: - Display table as part of string (probably as a separate UI view)
//TODO: - Display titled paragraphs

struct AttributedText: View {
    let text: String
    
    var body: some View {
        AttributedTextView(text: text)
            .lineSpacing(4)
    }
    
    private
    func AttributedTextView(text: String) -> Text {
        enum Rules: String, CaseIterable {
            case die = "[0-9]+d[0-9]+"
            case damage = "(acid|fire|cold|thunder|poison|necrotic|radient|force|bludgeoning|piercing|slashing) damage"
            
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
                return nil
            }
        }
    
        if let range = text.range(of: Rules.all(), options: .regularExpression) {
            
            let attributedView: Text = {
                switch Rules.match(String(text[range])) {
                case .die: return DieTextView(String(text[range]))
                case .damage: return DamageTextView(String(text[range]))
                default: return Text(String(text[range]))
                }
            }()
            
            return         Text(text[text.startIndex..<range.lowerBound]) +
                attributedView +
                AttributedTextView(text: String(text[range.upperBound..<text.endIndex]))
        }
        else {
            return Text(text)
        }
    }
    

//MARK: - SubViews
    private
    func DieTextView(_ text: String) -> Text {
        return Text(text)
            .bold()
            .font(.system(size: 18))
    }
    
    private
    func DamageTextView(_ text: String, color: Color = .blue) -> Text {
        return Text(text)
            .bold()
            .font(.system(size: 18))
            .foregroundColor(color)
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
            
            DataTableView(table: JSONTable(
                            title: "Animated Object Statistics",
                            headers: ["Size", "HP", "AC", "Attack", "STR", "DEX"],
                            rows: [
                                ["Tiny", "20", "18", "+8 to hit,\n1d4+4 damage", "4", "8"],
                                ["Small", "25", "16", "+6 to hit,\n1d8+2 damage", "6", "14"],
                                ["Medium", "40", "13", "+5 to hit,\n2d6+1 damage", "10", "12"],
                                ["Large", "50", "10", "+6 to hit,\n2d10+2 damage", "14", "10"],
                                ["Huge", "80", "10", "+8 to hit,\n2d12 + 4 damage", "18", "6"]
                            ]))
                .previewLayout(.fixed(width: 700, height: 700))
        }
    }
}
