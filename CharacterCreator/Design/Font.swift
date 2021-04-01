//
//  Font.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 11/30/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import SwiftUI

extension Font {
    struct App {
        public static var caption: Font {
            return Font.caption
        }
        public static var header: Font {
            return Font.title3
        }
        public static var headline: Font {
            return Font.headline
        }
        public static var subheadline: Font {
            return Font.subheadline
        }
        public static var body: Font {
            return Font.body
        }
        
        
        public static var featureTitle: Font {
            return Font.subheadline.bold()
        }
    }
}
