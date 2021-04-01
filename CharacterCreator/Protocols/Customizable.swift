//
//  Customizable.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/9/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation


protocol Customizable: Codable {
    var isCustom: Bool { get }
}

extension Customizable where Self: Codable {
    static func allCustom() throws -> [Self] {
        let filename: String = {
            let name = "custom" + String(describing: Self.self).capitalized.dropLast(6)
            return name.last == "s" ? name + "es" : name + "s"
        }()

        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoded = try? JSONDecoder().decode([Self].self, from: data)
            return decoded == nil ? [Self]() : decoded!
            }
            catch {
                print("error while parsing JSON for file \(filename).json")
                print(error)
                throw JSONError.parsingError
        }
    }

    static func saveCustom(_ record: Self) throws {
        let filename: String = {
            let name = "custom" + String(describing: Self.self).capitalized.dropLast(6)
            return name.last == "s" ? name + "es" : name + "s"
        }()

        guard let path = Bundle.main.path(forResource: filename, ofType: "json")
        else { print("file not found for \(filename).json"); throw JSONError.fileNotFound }

        var all = try allCustom()

        all.append(record)
        
        let jsonData = try JSONEncoder().encode(all)
        try jsonData.write(to: URL(fileURLWithPath: path))
    }
}
