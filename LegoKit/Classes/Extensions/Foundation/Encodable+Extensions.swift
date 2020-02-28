//
//  Encodable+Extensions.swift
//  LegoKit
//
//  Created by forkon on 2020/2/28.
//

extension Encodable {

    public func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)

        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }

        return dictionary
    }

}
