//
//  APIResource.swift
//  MADiOS
//
//  Created by Bram Rampelberg on 03/01/2025.
//  Copyright © 2025 HOGENT. All rights reserved.
//

import Foundation

enum APIResource<T> {
    case succes(data: T, statusCode: Int)
    case loading
    case error(Error, statusCode: Int)
}
