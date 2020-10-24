//
//  ValueTransformers.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 10/23/20.
//  Copyright © 2020 Ike Mattice. All rights reserved.
//

import Foundation
import CoreData



//MARK: - RaceRecord
//fileprivate
//class ManagedRaceDescriptive: NSManagedObject {
//@NSManaged var age: String
//@NSManaged var alignment: String
//@NSManaged var physique: String
//
//    var student: RaceRecord.Descriptive {
//        get {
//            return RaceRecord.Descriptive(age: age, alignment: alignment, physique: physique)   }
//        set {
//            self.age = newValue.age
//            self.alignment = newValue.alignment
//            self.physique = newValue.physique       }
//    }
//}

// 1. Subclass from `NSSecureUnarchiveFromDataTransformer`
//@objc(RaceDescriptiveTransformer)
//final class RaceDescriptiveTransformer: NSSecureUnarchiveFromDataTransformer {
//
//    /// The name of the transformer. This is the name used to register the transformer using `ValueTransformer.setValueTrandformer(_"forName:)`.
//    static let name = NSValueTransformerName(rawValue: String(describing: RaceDescriptiveTransformer.self))
//
//    // 2. Make sure `UIColor` is in the allowed class list.
//    override static var allowedTopLevelClasses: [AnyClass] {
//        return [RaceRecord.Descriptive.self]
//    }
//
//    /// Registers the transformer.
//    public static func register() {
//        let transformer = RaceDescriptiveTransformer()
//        ValueTransformer.setValueTransformer(transformer, forName: name)
//    }
//}

//public class RaceDescriptiveTransformer<T: NSCoding & NSObject>: ValueTransformer {
//     public override class func transformedValueClass() -> AnyClass{T.self }
//     public override class func allowsReverseTransformation() -> Bool { true }
//     public override func transformedValue(_ value: Any?) -> Any? {
//         guard let value = value as? T else { return nil }
//         return try?
//             NSKeyedArchiver.archivedData(withRootObject: value,
//             requiringSecureCoding: true)
//     }
//    public override func reverseTransformedValue(_ value: Any?) ->
//    Any? {
//         guard let data = value as? NSData else { return nil }
//         let result = try? NSKeyedUnarchiver.unarchivedObject(
//             ofClass: T.self,
//             from: data as Data
//         )
//         return result
//    }
//       /// The name of this transformer. This is the name used to
//       ///    register the transformer using `ValueTransformer.setValueTransformer(_:forName:)`
//     public static var transformerName: NSValueTransformerName {
//        let className = String(describing: T.self.classForCoder()) //.classForCoder())”
//         return NSValueTransformerName(“\(className)Transformer”) //
////                we append the Transformer due easily identify.
////                Example. Clase name UserSetting then the name
////                of the transformer is UserSettingTransformer
//      }
//
//          /// Registers the transformer by calling  `ValueTransformer.setValueTransformer(_:forName:)`.
//     public static func registerTransformer() {
//        let transformer = RaceDescriptiveTransformer<T>()
//        ValueTransformer.setValueTransformer(transformer, forName:
//        transformerName)
//     }
//}
