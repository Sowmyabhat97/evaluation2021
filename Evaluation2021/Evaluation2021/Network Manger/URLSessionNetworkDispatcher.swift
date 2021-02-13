//
//  URLSessionNetworkDispatcher.swift
//  Evaluation2021
//
//  Created by Sowmya on 12/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import Foundation


public enum ConnError: Swift.Error {
    case invalidURL
    case noData
}

/// Singleton class the make network request

public struct URLSessionNetworkDispatcher: NetworkDispatcher {
    
    public static let shared = URLSessionNetworkDispatcher()
    
    private init() {}
    
    public func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidURL)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        if let body = request.body {
            urlRequest.httpBody = body
        }
        if let auth = request.headers {
            urlRequest.addValue(auth, forHTTPHeaderField: "Authorization")
        }
        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            }
        } catch let error {
            onError(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            
            guard let _data = data else {
                onError(ConnError.noData)
                return
            }
            
            onSuccess(_data)
        }.resume()
    }
}
