//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/13/23.
//

import Foundation
import Vapor

public extension ClientResponse {
    
    func validate<ErrorType: NoVaporAPIError>(type: ErrorType.Type, using decoder: ContentDecoder? = nil) throws -> Self {
        let code = Int(status.code)
        let validCodes = 200...299
        guard validCodes.contains(code) else {
            if let decoder = decoder {
                throw try content.decode(type, using: decoder)
            } else {
                throw try content.decode(type)
            }
        }
        return self
    }
    
   
}
