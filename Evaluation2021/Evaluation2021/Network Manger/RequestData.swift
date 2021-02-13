//
//  RequestData.swift
//  Evaluation2021
//
//  Created by Sowmya on 12/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
}

public struct RequestData {
    public let path: String
    public let method: HTTPMethod
    public let params: [String: Any?]?
    public let headers: String?
    public let body: Data?
    
    public init (
        urlPath path: String,
        method: HTTPMethod = HTTPMethod.get,
        params: [String: Any?]? = nil,
        headers: String? = nil,
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.body = body
    }
}
