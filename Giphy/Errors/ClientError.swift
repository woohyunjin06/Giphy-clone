//
//  ClientError.swift
//  Giphy
//
//  Created by 현진 on 2021/01/10.
//

import Foundation

enum ClientError: Error {
    case statusErrorUndecodable(statusCode: Int)
    case statusError(statusCode: Int, message: String)
    case unhandledError(Error)
}
