//
//  NetworkManager.swift
//  Evaluation2021
//
//  Created by Sowmya on 12/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import Foundation

class NetworkManager : NSObject {
    
    func getData<T: Codable>(url : String?, model: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        if let url = url {
            URLSessionNetworkDispatcher.shared.dispatch(request: RequestData(urlPath: url, headers: "563492ad6f91700001000001f9ffe5521b68479fba9c225eaa25f936"), onSuccess: { (responseData: Data) in
                do {
                    let result = try JSONDecoder().decode(T.self, from: responseData)
                    DispatchQueue.main.async {
                        completionHandler(.success(result))
                    }
                } catch let error {
                    print(error)
                    completionHandler(.failure(error))
                }
            }) { (error : Error) in
                completionHandler(.failure(error))
            }
        }
    }
}
