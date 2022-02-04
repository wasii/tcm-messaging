//
//  Model.swift
//  messaging-tcm
//
//  Created by Wasiq Saleem on 02/02/2022.
//

import Foundation

struct Model: Codable {
    let name: String
}


struct TokenModel: Codable {
    let returnStatus: ReturnStatus
}

// MARK: - ReturnStatus
struct ReturnStatus: Codable {
    let code, status, tcmToken: String
}
