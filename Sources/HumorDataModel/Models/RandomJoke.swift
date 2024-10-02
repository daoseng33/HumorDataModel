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
    
    enum CodingKeys: String, CodingKey {
        case id, joke
    }

    public required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        joke = try container.decode(String.self, forKey: .joke)
    }
    
    public override init() {
        super.init()
    }
}
