//
//  String.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/24/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

extension String {
	func replacingLastOccurrenceOfString(_ searchString: String,
										 with replacementString: String,
										 caseInsensitive: Bool = true) -> String {
		let options: String.CompareOptions
		if caseInsensitive {
			options = [.backwards, .caseInsensitive]
		} else {
			options = [.backwards]
		}

		if let range = self.range(of: searchString,
								  options: options,
								  range: nil,
								  locale: nil) {

			return self.replacingCharacters(in: range, with: replacementString)
		}
		return self
	}
	
	//check if a string matches a specific regex pattern
	func matches(_ regex: String) -> Bool {
		return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
	}

}
