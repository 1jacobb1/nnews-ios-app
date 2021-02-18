//
//  Predicates.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import Foundation

class Predicates {
    static func q() -> NSPredicate {
        return NSPredicate.q
    }

    static func eq(k property: Query) -> NSPredicate {
        return eq(k: property, v: true)
    }

    static func not(k property: Query) -> NSPredicate {
        return eq(k: property, v: false)
    }

    static func eq(k property: Query, v: Any) -> NSPredicate {
        return NSPredicate(property.rawValue, eq: v as AnyObject)
    }

    static func neq(k property: Query, v: Any) -> NSPredicate {
        return NSPredicate(property.rawValue, neq: v as AnyObject)
    }

    static func isEmpty(k property: Query) -> NSPredicate {
        return NSPredicate(property.rawValue, eq: "" as AnyObject)
    }

    static func isNotEmpty(k property: Query) -> NSPredicate {
        return NSPredicate(property.rawValue, neq: "" as AnyObject)
    }

    static func contains(k property: Query, v: String) -> NSPredicate {
        return NSPredicate(property.rawValue, contains: v as AnyObject)
    }

    static func valuesIn(k property: Query, v: [Any]) -> NSPredicate {
        return NSPredicate(property.rawValue, valuesIn: v as [AnyObject])
    }

    static func valuesNotIn(k property: Query, v: [Any]) -> NSPredicate {
        return NSPredicate(property.rawValue, valuesNotIn: v as [AnyObject])
    }
}
