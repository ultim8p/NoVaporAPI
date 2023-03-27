//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/13/23.
//

import Foundation
import Vapor

public extension ClientResponse {
    
    func value<T: Content>(using decoder: ContentDecoder?) throws -> T {
        if let decoder = decoder {
            return try content.decode(T.self, using: decoder)
        }
        return try content.decode(T.self)
    }
    
}
