//
//  RandomJoke.swift
//  MemeData
//
//  Created by DAO on 2024/9/18.
//

import Foundation
import RealmSwift

public class RandomJoke: Object, Decodable {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var joke: String
    @Persisted public var createdAt: Date = Date()
    
    public override init() {
        super.init()
    }
}
