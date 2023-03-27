//
//  File.swift
//  
//
//  Created by Guerson Perez on 3/13/23.
//

import Foundation
import Vapor

public extension Content {
    
}

public extension Content {
    
    func post(_ client: Client,
              uri: URI,
              query: Encodable? = nil,
              headers: [(String, String)],
              queryEncoder: URLQueryEncoder? = nil,
              contentEncoder: ContentEncoder? = nil
          ) async throws -> ClientResponse {
              let headers = HTTPHeaders(headers)
              let response = try await client.post(uri, headers: headers, beforeSend: { req in
                  try req.content.encode(self, using: contentEncoder ?? JSONEncoder())
                  if let query = query, let encoder = queryEncoder {
                      try req.query.encode(query, using: encoder)
                  } else if let query = query {
                      try req.query.encode(query)
                  }
              })
              return response
          }
    
    func post(
        _ client: Client,
        scheme: String,
        host: String,
        port: Int? = nil,
        path: CustomStringConvertible? = nil,
        query: Encodable? = nil,
        headers: [(String, String)],
        queryEncoder: URLQueryEncoder? = nil,
        contentEncoder: ContentEncoder? = nil
    ) async throws -> ClientResponse {
        let uri = URI(scheme: scheme, host: host, port: port, path: path?.description ?? "")
        return try await post(
            client,
            uri: uri,
            query: query,
            headers: headers,
            queryEncoder: queryEncoder,
            contentEncoder: contentEncoder
        )
    }
}
