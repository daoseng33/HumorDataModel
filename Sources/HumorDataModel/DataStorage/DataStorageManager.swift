//
//  DataStorage.swift
//  MemeData
//
//  Created by DAO on 2024/9/25.
//

import Foundation
import RealmSwift

@MainActor
final public class DataStorageManager {
    // MARK: - Properties
    static public let shared = DataStorageManager()
    
    // MARK: - Init
    private init() {}
    
    private func realm(for configuration: Realm.Configuration = .defaultConfiguration) throws -> Realm {
        return try Realm(configuration: configuration)
    }
    
    public func save<T: Object>(_ object: T, onError: ((Error?) -> Void)? = nil) {
        do {
            let realm = try self.realm()
            
            realm.writeAsync {
                realm.add(object, update: .modified)
            } onComplete: { error in
                onError?(error)
            }
            
        } catch {
            onError?(error)
        }
    }
    
    public func fetch<T: Object>(_ type: T.Type, completion: @escaping (Result<[T], Error>) -> Void) {
        do {
            let realm = try self.realm()
            let results = realm.objects(type)
            let array = Array(results)
            completion(.success(array))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func fetchAsync<T: Object>(_ type: T.Type) async throws -> [T] {
        let realm = try self.realm()
        let results = realm.objects(type)
        return Array(results)
    }
    
    public func update<T: Object>(_ object: T, with dictionary: [String: Any?], onError: ((Error?) -> Void)? = nil) {
        do {
            let realm = try self.realm()
            
            realm.writeAsync {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            } onComplete: { error in
                onError?(error)
            }
        } catch {
            onError?(error)
        }
    }
    
    public func delete<T: Object>(_ object: T, onError: ((Error?) -> Void)? = nil) {
        do {
            let realm = try self.realm()
            
            realm.writeAsync {
                realm.delete(object)
            } onComplete: { error in
                onError?(error)
            }
        } catch {
            onError?(error)
        }
    }
    
    public func migrate() {
        let config = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 1 {
                        migration.enumerateObjects(ofType: ImageData.className()) { oldObject, newObject in
                            newObject!["createdAt"] = Date()
                        }
                        migration.enumerateObjects(ofType: RandomJoke.className()) { oldObject, newObject in
                            newObject!["createdAt"] = Date()
                        }
                    }
                }
            )
            
            Realm.Configuration.defaultConfiguration = config
            
            do {
                let _ = try Realm()
            } catch {
                print("Error opening Realm: \(error)")
            }
    }
}
