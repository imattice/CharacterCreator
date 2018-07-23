//
//  ExpandableTableViewData.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/2/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//
struct DropdownCellData {
	//tracks if the cell is open or closed
	var isOpen: Bool 			= false

	var parentData: (title: String, description: String)
	var childData: [(title: String, description: String)]?


	init(title: String, description: String) {
		self.isOpen 		= false
		self.parentData 	= (title: title, description: description)
	}

	static func createArray(forDataType dataType: DataType) -> [DropdownCellData] {
		let sourceArray: [String: Any]
		let childKey: String

		var result = [DropdownCellData]()

		//set source-specific values
		switch dataType {
		case .class: 	sourceArray = classData; childKey = "paths"
		case .race:		sourceArray = raceData;  childKey = "subraces"
		}

		//loop through parent data
		for parent in sourceArray {
			guard let parentDict = parent.value as? [String : Any],
				let description = parentDict["description"] as? String
				else { print("could not create \(parent.key) parent data from available data"); return [DropdownCellData]() }

			let parentTitle: String 			= parent.key
			let parentDescription: String 		= description
			var childData: [(title: String, description: String)]?

			//check for available childData
			if let childDict = parentDict[childKey] as? [String : [String: Any]] {
				var childArray = [(title: String, description: String)]()

				//loop through child Data
				for childData in childDict {

					//fetch the description
					if let description = childData.value["description"] as? String {

						childArray.append((title: childData.key, description: description))
					}
				}

				childData = childArray
			}

			//create the data object here so we can add to it if there is child data
			var parentData = DropdownCellData(title: parentTitle, description: parentDescription)

			if childData != nil {
				parentData.childData = childData
			}

				result.append(parentData)
			}

			return result
		}

}
