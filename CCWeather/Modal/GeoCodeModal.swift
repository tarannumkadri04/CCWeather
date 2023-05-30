//
//  GeoCodeModal.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 30/05/23.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

// MARK: - GeoCodeModal

struct GeoCodeModal: Codable {
    
    let name: String?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name        
        case lat, lon, country, state
    }
}

// MARK: GeoCodeModal convenience initializers and mutators

extension GeoCodeModal {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(GeoCodeModal.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

