//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/13/23.
//

import Foundation
import Vapor

public extension ClientResponse {
    
    func value<ValueType: Content>(using decoder: ContentDecoder?) throws -> ValueType {
        if let decoder = decoder {
            return try content.decode(ValueType.self, using: decoder)
        }
        return try content.decode(ValueType.self)
    }
}
