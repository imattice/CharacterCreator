//
//  ValueTransformers.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/23/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData


//Custom ValueTransformers prevent the Core Data warning from the default transformer


//MARK: - RaceRecord
@objc(RaceDescriptiveTransformer)
final class RaceDescriptiveTransformer: NSSecureUnarchiveFromDataTransformer {

    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
    static let name = NSValueTransformerName(rawValue: String(describing: RaceDescriptiveTransformer.self))

    // 2. Make sure the class is in the allowed class list.
    override static var allowedTopLevelClasses: [AnyClass] {
        return [RaceRecord.Descriptive.self]
    }

    /// Registers the transformer.
    public static func register() {
        let transformer = RaceDescriptiveTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
//        print("names:")
//        print(valueTransformerNames())
    }
}

//public class RecordValueTransformer<T: NSSecureCoding & NSObject>: NSSecureUnarchiveFromDataTransformer {
//     public override class func transformedValueClass() ->
//            AnyClass{T.self }
//
//     public override class func allowsReverseTransformation() ->
//            Bool { true }
//    
//    public override static var allowedTopLevelClasses: [AnyClass] {
//            return [T.self] //[RaceRecord.Descriptive.self]
//        }
//
//     public override func transformedValue(_ value: Any?) -> Any? {
//         guard let value = value as? T else { return nil }
//         return try?
//             NSKeyedArchiver.archivedData(withRootObject: value,
//             requiringSecureCoding: true)
//     }
//
//    public override func reverseTransformedValue(_ value: Any?) ->
//    Any? {
//         guard let data = value as? NSData else { return nil }
//         let result = try? NSKeyedUnarchiver.unarchivedObject(
//             ofClass: T.self,
//             from: data as Data
//         )
//         return result
//    }
//
//    /// The name of this transformer. This is the name used to register the transformer using `ValueTransformer.setValueTransformer(_:forName:)`
//     public static var transformerName: NSValueTransformerName {
//        let className = String(describing: T.self.classForCoder())
////        print("Transformer Name: \(className)")
//        return NSValueTransformerName("\(className)Transformer")
//        //we append the Transformer due easily identify. Example. Clase name UserSetting then the name of the transformer is UserSettingTransformer
//      }
//          
//    /// Registers the transformer by calling `ValueTransformer.setValueTransformer(_:forName:)`.
//     public static func register() {
//        let transformer = RecordValueTransformer<T>()
//        ValueTransformer.setValueTransformer(transformer, forName:
//        transformerName)
//        print("names:")
//        print(valueTransformerNames())
//     }
//}
