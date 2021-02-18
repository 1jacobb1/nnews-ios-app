//
//  NSPredicate+Extensions.swift
//  nnews
//
//  Created by Jacob on 2/18/21.
//

import Foundation

extension NSPredicate {
    static var q: NSPredicate {
        return NSPredicate(value: true)
    }

    convenience init(_ property: String, eq value: AnyObject) {
        self.init(expression: property, "==", value)
    }

    convenience init(_ property: String, neq value: AnyObject) {
        self.init(expression: property, "!=", value)
    }

    convenience init(_ property: String, contains q: AnyObject) {
        self.init(expression: property, "CONTAINS[c]", q)
    }

    convenience init(_ property: String, valuesIn values: [AnyObject]) {
        self.init(expression: property, "IN", values)
    }

    convenience init(_ property: String, valuesNotIn values: [AnyObject]) {
        self.init(expression: property, "IN", values, not: true)
    }

    convenience init(_ property: String, gte value: AnyObject) {
        self.init(expression: property, ">=", value)
    }

    convenience init(_ property: String, gt value: AnyObject) {
        self.init(expression: property, ">", value)
    }

    convenience init(_ property: String, lte value: AnyObject) {
        self.init(expression: property, "<=", value)
    }

    convenience init(_ property: String, lt value: AnyObject) {
        self.init(expression: property, "<", value)
    }

    convenience init(_ property: String, from min: AnyObject, to max: AnyObject) {
        self.init(format: "\(property) BETWEEN {%@, %@}", argumentArray: [min, max])
    }

    fileprivate convenience init(expression property: String, _ operation: String, _ value: AnyObject) {
        self.init(format: "\(property) \(operation) %@", argumentArray: [value])
    }

    fileprivate convenience init(expression property: String,
                                 _ operation: String,
                                 _ values: [AnyObject],
                                 not: Bool = false) {
        if !not {
            self.init(format: "\(property) \(operation) %@", argumentArray: [values])
        } else {
            self.init(format: "NOT (\(property) \(operation) %@)", argumentArray: [values])
        }
    }

    func and(_ predicate: NSPredicate) -> NSPredicate {
        return self.compound([predicate])
    }

    func or(_ predicate: NSPredicate) -> NSPredicate {
        return self.compound([predicate], type: .or)
    }

    func not(_ predicate: NSPredicate) -> NSPredicate {
        return self.compound([predicate], type: .not)
    }

    func compound(_ predicates: [NSPredicate], type: NSCompoundPredicate.LogicalType = .and) -> NSPredicate {
        var p = predicates
        p.insert(self, at: 0)
        switch type {
        case .and:
            return NSCompoundPredicate(andPredicateWithSubpredicates: p)
        case .or:
            return NSCompoundPredicate(andPredicateWithSubpredicates: p)
        case .not:
            return NSCompoundPredicate(andPredicateWithSubpredicates: p)
        @unknown default:
            fatalError("error!")
        }
    }
}
