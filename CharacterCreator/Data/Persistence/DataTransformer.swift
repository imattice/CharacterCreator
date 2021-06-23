//
//  DataTransformer.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/21/21.
//  Copyright © 2021 Ike Mattice. All rights reserved.
//

import Foundation

@objc(ItemDataTransformer)
class ItemDataTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] { [NSArray.self, Item.self] }
    
    static func register() {
        let name = NSValueTransformerName(String(describing: ItemDataTransformer.self))
        let transformer = ItemDataTransformer()
        
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
