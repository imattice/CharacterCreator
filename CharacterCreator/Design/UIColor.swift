//
//  UIColor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/12/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit
import Hue

protocol Paintable {
	func paint()
}

extension UIColor {

	static func color(for targetClass: AvailableClass ) -> UIColor {
		switch targetClass {
		case .cleric: 		return UIColor.MaterialColor.lightBlue
		case .fighter: 		return UIColor.MaterialColor.red
		case .rogue: 		return UIColor.MaterialColor.green
		case .wizard:		return UIColor.MaterialColor.deepPurple
		}
	}
	static func gradient(for targetClass: AvailableClass ) -> [UIColor] {
		switch targetClass {
		case .cleric: 		return UIColor.MaterialColor.lightBlueGradientColors
		case .fighter: 		return UIColor.MaterialColor.redGradientColors
		case .rogue: 		return UIColor.MaterialColor.greenGradientColors
		case .wizard:		return UIColor.MaterialColor.deepPurpleGradientColors
		}
	}
	static func colorForCurrentClass() -> UIColor {
		if let characterClass = Character.current.class,
			let availableClass = AvailableClass(rawValue: characterClass.base.lowercased()) {

			return color(for: availableClass)
		}
		else if let characterClass = Character.default.class,
			let availableClass = AvailableClass(rawValue: characterClass.base.lowercased()) {

			return color(for: availableClass)}

		print("false color")
		return UIButton(type: .system).tintColor
	}

	static func gradientForCurrentClass() -> [UIColor] {
		if let characterClass = Character.current.class,
			let availableClass = AvailableClass(rawValue: characterClass.base.lowercased()) {

			return gradient(for: availableClass)
		}
		else if let characterClass = Character.default.class,
			let availableClass = AvailableClass(rawValue: characterClass.base.lowercased()) {

			return gradient(for: availableClass)}

		print("false color")
		return [UIButton(type: .system).tintColor]
	}

	static func lightestShadeForCurrentClass() -> UIColor {
		var targetClass: AvailableClass
		if let currentClass = Character.current.class {
			targetClass = AvailableClass(rawValue: currentClass.base)!  }
		else {
			targetClass = AvailableClass(rawValue: Character.default.class!.base)!
		}

		return gradient(for: targetClass).first!
	}

	static func darkestShadeForCurrentClass() -> UIColor {
		var targetClass: AvailableClass
		if let currentClass = Character.current.class {
			targetClass = AvailableClass(rawValue: currentClass.base)!  }
		else {
			targetClass = AvailableClass(rawValue: Character.default.class!.base)!
		}

		return gradient(for: targetClass).last!
	}



	//https://www.materialui.co/colors
	struct MaterialColor {
		static let red			= UIColor(hex: "f44336")
		static let pink			= UIColor(hex: "E91E63")
		static let purple		= UIColor(hex: "9C27B0")
		static let deepPurple	= UIColor(hex: "673AB7")
		static let indigo		= UIColor(hex: "3F51B5")
		static let blue			= UIColor(hex: "2196F3")
		static let lightBlue	= UIColor(hex: "03A9F4")
		static let cyan			= UIColor(hex: "00BCD4")
		static let teal			= UIColor(hex: "009688")
		static let green		= UIColor(hex: "4CAF50")
		static let lightGreen	= UIColor(hex: "8BC34A")
		static let lime			= UIColor(hex: "CDDC39")
		static let yellow		= UIColor(hex: "FFEB3B")
		static let amber		= UIColor(hex: "FFC107")
		static let orange		= UIColor(hex: "FF9800")
		static let deepOrange	= UIColor(hex: "FF5722")
		static let brown		= UIColor(hex: "795548")
		static let grey			= UIColor(hex: "9E9E9E")
		static let blueGrey		= UIColor(hex: "607D8B")


		static let redGradientColors =
			[UIColor(hex: "ffcdd2"), UIColor(hex: "ef9a9a"), UIColor(hex: "e57373"), UIColor(hex: "ef5350"), UIColor(hex: "f44336"), UIColor(hex: "e53935"), UIColor(hex: "d32f2f"), UIColor(hex: "c62828"), UIColor(hex: "b71c1c")]
		static let lightBlueGradientColors =
			[UIColor(hex: "B3E5FC"), UIColor(hex: "81D4FA"), UIColor(hex: "4FC3F7"), UIColor(hex: "29B6F6"), UIColor(hex: "03A9F4"), UIColor(hex: "039BE5"), UIColor(hex: "0288D1"), UIColor(hex: "0277BD"), UIColor(hex: "01579B")]
		static let blueGradientColors =
			[UIColor(hex: "BBDEFB"), UIColor(hex: "90CAF9"), UIColor(hex: "64B5F6"), UIColor(hex: "42A5F5"), UIColor(hex: "2196F3"), UIColor(hex: "1E88E5"), UIColor(hex: "1976D2"), UIColor(hex: "1565C0"), UIColor(hex: "0D47A1")]
		static let greenGradientColors =
			[UIColor(hex: "C8E6C9"), UIColor(hex: "A5D6A7"), UIColor(hex: "81C784"), UIColor(hex: "66BB6A"), UIColor(hex: "4CAF50"), UIColor(hex: "43A047"), UIColor(hex: "388E3C"), UIColor(hex: "2E7D32"), UIColor(hex: "1B5E20")]
		static let greyGradientColors =
			[UIColor(hex: "F5F5F5"), UIColor(hex: "EEEEEE"), UIColor(hex: "E0E0E0"), UIColor(hex: "BDBDBD"), UIColor(hex: "9E9E9E"), UIColor(hex: "757575"), UIColor(hex: "616161"), UIColor(hex: "424242"), UIColor(hex: "212121")]
		static let purpleGradientColors =
			[UIColor(hex: "E1BEE7"), UIColor(hex: "CE93D8"), UIColor(hex: "BA68C8"), UIColor(hex: "AB47BC"), UIColor(hex: "9C27B0"), UIColor(hex: "8E24AA"), UIColor(hex: "7B1FA2"), UIColor(hex: "6A1B9A"), UIColor(hex: "4A148C")]
		static let deepPurpleGradientColors =
			[UIColor(hex: "D1C4E9"), UIColor(hex: "B39DDB"), UIColor(hex: "9575CD"), UIColor(hex: "7E57C2"), UIColor(hex: "673AB7"), UIColor(hex: "5E35B1"), UIColor(hex: "512DA8"), UIColor(hex: "4527A0"), UIColor(hex: "311B92")]

		static let yellowGradientColors =
			[UIColor(hex: "FFF9C4"), UIColor(hex: "FFF59D"), UIColor(hex: "FFF176"), UIColor(hex: "FFEE58"), UIColor(hex: "FFEB3B"), UIColor(hex: "FDD835"), UIColor(hex: "FBC02D"), UIColor(hex: "F9A825"), UIColor(hex: "F57F17")]


	}
}
