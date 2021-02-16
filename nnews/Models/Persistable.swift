//
//  Persistable.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import RealmSwift

public protocol Persistable {
    associatedtype RealmObject: RealmSwift.Object
    init(realmObject obj: RealmObject)
    func managedObject() -> RealmObject
}
