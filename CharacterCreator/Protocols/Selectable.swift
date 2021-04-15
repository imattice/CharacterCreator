//
//  Selectable.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 4/14/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

protocol Selectable {
    var options: [SelectionOption] { get set }
    var selectionLimit: Int { get }
}

extension Selectable {
    var selections: [SelectionOption] { options.filter({ $0.isSelected == true })}
}

///A flexible object that describes a selection
struct Selection: Identifiable, Codable {
    ///The ID for the selection
    let id: String
    ///The number of selections that can be made
    let count: Int
    ///The available options to select from
    let options: [String]
    
    internal init(count: Int, options: [String]) {
        self.id = UUID().uuidString
        self.count = count
        self.options = options
    }
    
//    static
//    func decoded(from container: UnkeyedDecodingContainer) -> [Selection] {
//        var mutableContainer = container
//        var selections = [Selection]()
//        while !mutableContainer.isAtEnd {
//            do {
//            let selectionContainer = try mutableContainer.nestedContainer(keyedBy: CodingKeys.self)
//            let count = try selectionContainer.decode(Int.self, forKey: .selections)
//            let options = try selectionContainer.decode([String].self, forKey: .options)
//                selections.append(Selection(count: count, options: options))
//            }
//            catch {
//                print(error)
//            }
//        }
//        return selections
//    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(count, forKey: .selections)
//        try container.encode(options, forKey: .options)
//    }
    
//    enum CodingKeys: String, CodingKey {
//        case selections = "count", options
//    }
}

class SelectionOption: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let description: String?
    @Published var isSelected: Bool
    
    init(_ name: String, description: String? = nil, isSelected: Bool = false) {
        self.name = name
        self.description = description
        self.isSelected = false
    }
}

extension SelectionOption: Hashable, Equatable {
    static func == (lhs: SelectionOption, rhs: SelectionOption) -> Bool {
        return lhs.name == rhs.name &&
                lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
