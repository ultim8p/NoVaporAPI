//
//  Content.swift
//  
//
//  Created by Guerson Perez on 3/13/23.
//

import Foundation
import Vapor
import NoLogger

public extension Content {
    
    static func get(
        _ client: Client,
        uri: URI,
        headers: HTTPHeaders,
        timeout: Int64 = 60,
        logger: NoLogger? = nil
    )
    async throws -> ClientResponse {
        let response = try await client.get(uri, headers: headers, beforeSend: { req in
            req.timeout = .seconds(timeout)
            
            let request = req
            logger?.log(.debug, "NO API REQ: \(request)")
        })
        
        logger?.log(.debug, "NO API RESP: \(response)")
        return response
    }
    
    func get(
        _ client: Client,
        uri: URI,
        headers: HTTPHeaders,
        queryEncoder: URLQueryEncoder? = nil,
        timeout: Int64 = 60,
        logger: NoLogger? = nil
    ) async throws -> ClientResponse {
        let response = try await client.get(uri, headers: headers, beforeSend: { req in
            req.timeout = .seconds(timeout)
            try req.query.encode(self)
            
            let request = req
            logger?.log(.debug, "NO API REQ: \(request)")
        })
        
        logger?.log(.debug, "NO API RESP: \(response)")
        return response
    }
    
    func post(
        _ client: Client,
        uri: URI,
        query: Encodable? = nil,
        headers: HTTPHeaders,
        queryEncoder: URLQueryEncoder? = nil,
        contentEncoder: ContentEncoder? = nil,
        timeout: Int64 = 60,
        logger: NoLogger? = nil
    ) async throws -> ClientResponse {
        let response = try await client.post(uri, headers: headers, beforeSend: { req in
            req.timeout = .seconds(timeout)
            try req.content.encode(self, using: contentEncoder ?? JSONEncoder())
            if let query = query, let encoder = queryEncoder {
                try req.query.encode(query, using: encoder)
            } else if let query = query {
                try req.query.encode(query)
            }
            
            let request = req
            logger?.log(.debug, "NO API REQ: \(request)")
        })
        
        logger?.log(.debug, "NO API RESP: \(response)")
        return response
    }
    
    func delete(
        _ client: Client,
        uri: URI,
        headers: HTTPHeaders,
        queryEncoder: URLQueryEncoder? = nil,
        timeout: Int64 = 60,
        logger: NoLogger? = nil
    ) async throws -> ClientResponse {
        let response = try await client.delete(uri, headers: headers, beforeSend: { req in
            req.timeout = .seconds(timeout)
            if let encoder = queryEncoder {
                try req.query.encode(self, using: encoder)
            } else {
                try req.query.encode(self)
            }
            
            let request = req
            logger?.log(.debug, "NO API REQ: \(request)")
        })
        
        logger?.log(.debug, "NO API RESP: \(response)")
        return response
    }
    
    func post(
        _ client: Client,
        scheme: String,
        host: String,
        port: Int? = nil,
        path: CustomStringConvertible? = nil,
        query: Encodable? = nil,
        headers: HTTPHeaders,
        queryEncoder: URLQueryEncoder? = nil,
        contentEncoder: ContentEncoder? = nil,
        timeout: Int64,
        logger: NoLogger? = nil
    ) async throws -> ClientResponse {
        let uri = URI(scheme: scheme, host: host, port: port, path: path?.description ?? "")
        let response = try await post(
            client,
            uri: uri,
            query: query,
            headers: headers,
            queryEncoder: queryEncoder,
            contentEncoder: contentEncoder,
            timeout: timeout,
            logger: logger
        )
        
        logger?.log(.debug, "NO API RESP: \(response)")
        return response
    }
}
