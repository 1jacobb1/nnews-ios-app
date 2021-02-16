//
//  LocalDataManager.swift
//  nnews
//
//  Created by Jacob on 1/23/21.
//

import Foundation
import RealmSwift
import CocoaLumberjack

class LocalDataManager {
    static let thread = DispatchQueue(label: "Meishi.Realm.DataManager")
    
    private static let realmFilename = "nnews.realm"
    private static let schemaVersion: UInt64 = 1
    private static var configured = false
    
    static func configure() {
        var c = Realm.Configuration()
        c.fileURL = c.fileURL!
            .deletingLastPathComponent()
            .appendingPathComponent(realmFilename)
        c.deleteRealmIfMigrationNeeded = true
        c.readOnly = false
        c.schemaVersion = schemaVersion
        Realm.Configuration.defaultConfiguration = c
        configured = true
        let realmFileURL = Realm.Configuration.defaultConfiguration.fileURL?.absoluteString ?? ""
        DDLogInfo("Realm file destination: \(realmFileURL)")
        if !isValid() {
            reset()
        }
    }
    
    static func getInstance() throws -> Realm {
        var realm: Realm
        do {
            realm = try Realm()
        } catch {
            DDLogError("Realm error: \(error.localizedDescription)")
            realm = try Realm()
        }
        return realm
    }
    
    static func isValid() -> Bool {
        if !configured {
            configure()
        }
        do {
            let _ = try Realm()
            return true
        } catch {
            DDLogError("Realm is invalid error: \(error.localizedDescription)")
            return false
        }
    }
    
    static func reset() {
        remove()
        configure()
    }
    
    private static func remove() {
        guard let fileURL = Realm.Configuration.defaultConfiguration.fileURL else { return }
        let fileManager = FileManager.default
        let realmURLs = [
            fileURL,
            fileURL.appendingPathExtension("lock"),
            fileURL.appendingPathExtension("note")
        ]
        for url in realmURLs {
            do {
                if fileManager.fileExists(atPath: url.absoluteString) {
                    try fileManager.removeItem(at: url)
                }
            } catch {
                fatalError("unknown error.")
            }
        }
    }
}

extension LocalDataManager {
    static func write(block: @escaping () -> ()) {
        LocalDataManager.thread.async {
            guard let realm = try? LocalDataManager.getInstance() else { return }
            try? realm.write {
                block()
                realm.refresh()
            }
        }
    }
    
    static func save<T: Object>(type: T) {
        LocalDataManager.thread.async {
            guard let realm = try? LocalDataManager.getInstance() else { return }
            try? realm.write {
                realm.add(type, update: .modified)
            }
        }
    }
    
    static func save<T: Object>(type: [T]) {
        LocalDataManager.thread.async {
            guard let realm = try? LocalDataManager.getInstance() else { return }
            try? realm.write {
                realm.add(type, update: .modified)
                //realm.add(type)
            }
        }
    }
    
    static func delete<T: Object>(type: T) {
        LocalDataManager.thread.async {
            guard let realm = try? getInstance() else { return }
            try? realm.write {
                realm.delete(type)
            }
        }
    }
    
    static func delete<T: Object>(type: [T]) {
        LocalDataManager.thread.async {
            guard let realm = try? getInstance() else { return }
            try? realm.write {
                realm.delete(type)
            }
        }
    }
    
    static func getLastObject<T: Object>(type: T.Type) -> T? {
        guard let realm = try? getInstance(),
              let lastObject = realm.objects(type).sorted(byKeyPath: "id", ascending: false).first
        else { return nil }
        return lastObject
    }
    
//    static func deleteAllObjectOf<T: Object>(type: T) {
//        LocalDataManager.thread.async {
//            guard let realm = try? LocalDataManager.getInstance() else { return }
//            try? realm.write {
//                realm.delete(realm.objects(type.self))
//            }
//        }
//    }
}
