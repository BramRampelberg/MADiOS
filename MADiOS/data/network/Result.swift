//
//  APIResource.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(data: T)
    case failure(cause: String, error: Error? = nil)
    
    var isSuccess: Bool {
        switch self {
            case .success: return true
            case .failure: return false
        }
    }
    
    var isFailure: Bool {
        !isSuccess
    }
    
    var data: T? {
        switch self {
        case .success(let data): return data
        default: return nil
        }
    }
    
    var failureCause: String? {
        switch self {
        case .failure(let cause, _): return cause
        default: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .failure(_, let error): return error
        default: return nil
        }
    }
}
