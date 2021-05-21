//
//  DataTableView.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/21/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import SwiftUI

/// A view that displays content in a data table format
struct DataTableView: View {
    let table: DataTable
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
    
    init(table: DataTable, headerColor: Color = Color(hex: "#D0CEBA"), altRowColor: Color = Color(hex: "#E3E8E9")) {
        self.table = table
        self.headerBackgroundColor = headerColor
        self.altRowColor = altRowColor
    }
    
    init?(id tableId: String, headerColor: Color = Color(hex: "#D0CEBA"), altRowColor: Color = Color(hex: "#E3E8E9")) {
        guard let table = DataTable(id: tableId) else { print("cannot create table for id: '\(tableId)'"); return nil }
        
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
            Text(header == header.uppercased() ? header : header.capitalized)
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
                Text(rowData[index].capitalized)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        
        init(_ data: [String]) {
            self.rowData = data
        }
    }
}


struct DataTableView_Previews: PreviewProvider {
    static var previews: some View {
        DataTableView(id: "animated_object_statistics")
            .previewLayout(.fixed(width: 700, height: 700))    }
}
