//
//  ImageData.swift
//  MemeData
//
//  Created by DAO on 2024/9/22.
//

import Foundation
import RealmSwift

public class ImageData: Object, Decodable {
    @Persisted(primaryKey: true) public var urlString: String
    public var url: URL? {
        return URL(string: urlString)
    }
    @Persisted public var width: Int
    @Persisted public var height: Int
    @Persisted public var createdAt: Date = Date()
    
    enum CodingKeys: CodingKey {
        case url
        case width
        case height
    }
    
    required public init(from decoder: any Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        urlString = try container.decode(String.self, forKey: .url)
        width = try container.decode(Int.self, forKey: .width)
        height = try container.decode(Int.self, forKey: .height)
    }
    
    public override init() {
        super.init()
    }
}
