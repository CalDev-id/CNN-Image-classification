//
//  APIModel.swift
//  INDODOCS
//
//  Created by Heical Chandra on 25/07/24.
//

import Foundation

struct ChatRequest: Codable {
    let user_prompt: String
}

struct ChatResponse: Codable {
    let response: String
}
