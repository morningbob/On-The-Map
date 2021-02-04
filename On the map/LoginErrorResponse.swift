//
//  LoginErrorResponse.swift
//  On the map
//
//  Created by Jessie Hon on 2021-02-04.
//

import Foundation

struct LoginErrorResponse: Codable {
  let status: Int
  let errorMessage: String
}

extension LoginErrorResponse: LocalizedError {
  var errorDescription: String? {
    return errorMessage
  }
}
