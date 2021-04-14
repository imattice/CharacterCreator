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
