//
//  Color.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/30/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

extension Color {
    
    ///https://coolors.co/a21622-da4e4a-ceec97-7a28cb-494368-5a5476-d3d1dc
    ///French Violet
    public static var primary: Color {
        return Color(hex: "7A28CB")
    }
    ///Glossy Grape
    public static var primaryHighlight: Color {
        return Color(hex: "A599B5")
    }
    ///Ruby Red
    public static var secondary: Color {
        return Color(hex: "A21622")
    }
    ///Ceder Chest
    public static var secondaryHighlight: Color {
        return Color(hex: "DA4E4A")
    }
    ///Independence
    public static var background: Color {
        return Color(hex: "5A5476")
    }
    ///Yellow Green Crayola
    public static var highlight: Color {
        return Color(hex: "CEEC97")
    }
    ///Lavender Gray
    public static var surface: Color {
        return Color(hex: "D3D1DC")
    }
}

//MARK: - Hex Initialization
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
