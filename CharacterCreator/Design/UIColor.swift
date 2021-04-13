//
//  UIColor.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 7/12/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

protocol Paintable {
	func paint()
}

extension UIColor {
    public convenience init(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 0)
        return
    }

//	static func color(for targetClass: AvailableClass ) -> AppColor {
//		switch targetClass {
//		case .cleric: 		return UIColor.AppColor.blue
//		case .fighter: 		return UIColor.AppColor.red
//		case .rogue: 		return UIColor.AppColor.green
//		case .wizard:		return UIColor.AppColor.purple
//		}
//	}
//	static func gradient(for targetClass: AvailableClass ) -> [UIColor] {
//		switch targetClass {
//		case .cleric: 		return UIColor.MaterialColor.lightBlueGradientColors
//		case .fighter: 		return UIColor.MaterialColor.redGradientColors
//		case .rogue: 		return UIColor.MaterialColor.greenGradientColors
//		case .wizard:		return UIColor.MaterialColor.deepPurpleGradientColors
//		}
//	}


	enum AppColor {
		case red, green, blue, purple

		func base() -> UIColor {
			switch self {
			case .red: 		return UIColor(hex: "DC413A")
			case .green: 	return UIColor(hex: "47A64D")
			case .blue:		return UIColor(hex: "3F9AC9")
			case .purple:	return UIColor(hex: "5C4287")
			}
		}

		func lightColor() -> UIColor {
			switch self {
			case .red: 		return UIColor(hex: "F4827E")
			case .green: 	return UIColor(hex: "A4EAA4")
			case .blue:		return UIColor(hex: "8CD3F3")
			case .purple:	return UIColor(hex: "8C7CB9")
			}
		}

		func darkColor() -> UIColor {
			switch self {
			case .red: 		return UIColor(hex: "7D251D")
			case .green: 	return UIColor(hex: "387E3D")
			case .blue:		return UIColor(hex: "205D7D")
			case .purple:	return UIColor(hex: "513B7E")
			}
		}
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
