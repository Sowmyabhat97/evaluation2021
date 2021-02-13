//
//  NetworkDispatcher.swift
//  Evaluation2021
//
//  Created by Sowmya on 12/02/21.
//  Copyright © 2021 Sowmya. All rights reserved.
//

import Foundation

public protocol NetworkDispatcher {
    /**
     *  Method to dispatch request.
     *  - Parameter request:    of type **RequestData**
     *  - Parameter onSuccess:   Handler for success
     *  - Parameter onError:   Handler for failure
     */
    func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}
