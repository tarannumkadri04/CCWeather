// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try Welcome(json)

import Foundation

// MARK: - Welcome
struct TestModal: Codable {
    
    let userID: JSONAny?
    let userSession: String?
    
    func getUserId() -> String {
        var value = String()
        if let v = userID?.value as? String {
            value = v
        } else if let vi = userID?.value as? Int {
            value = String(vi)
        }
        return value
    }
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userSession = "user_session"
    }
}

// MARK: Welcome convenience initializers and mutators

extension TestModal {
    
    init(data: Data) throws {
        self = try newJSONDecoder().decode(TestModal.self, from: data)
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

