//
//  ExpandableTableViewData.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

struct ExpandableCellData {
	//tracks if the cell is open or closed
	var isOpen: Bool 			= false

	var parentData: (object: Any, description: String)
	var childData: [(object: Any, description: String)]?


	init(parentData: Any, description: String) {
		self.isOpen 		= false
		self.parentData 	= (object: parentData, description: description)
	}
}
