//
//  DataTable.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 5/21/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//
import Foundation

///Contains data that can be displayed in a Data Table View
struct DataTable: Codable {
    /// The display title of the table
    let title: String
    /// The headers of the columns of the tables
    let headers: [String]
    /// The data for the individual rows of the table, where each array is a new row, and each row contains a number of strings representing the item in the table
    let rows: [[String]]
    /// A unique identifier used to position the table within a Text view
    let tag: String
    
    ///Converts JSON file data to Objects
    static
    func parseAllFromJSON() throws -> [Self] {
        guard let path = Bundle.main.path(forResource: "tables", ofType: "json")
        else { print("file not found for tables.json"); throw JSONError.fileNotFound }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: [])
            return try JSONDecoder().decode([Self].self, from: data)
        }
        catch {
            print("error while parsing JSON for file tables.json")
            print(error)
            throw JSONError.parsingError
        }
    }
    
    init?(id: String) {
        guard let table = try? DataTable.parseAllFromJSON().filter({ $0.tag == id }).first else { return nil }
        self = table
    }
    init(title: String, headers: [String], rows: [[String]], tag: String) {
        self.title = title
        self.headers = headers
        self.rows = rows
        self.tag = tag
    }
}
