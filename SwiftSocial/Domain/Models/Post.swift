//
//  Post.swift
//  SwiftSocial
//
//  Created by Phyo Myanmar Kyaw on 10/31/25.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: String
    let text: String
    let authorUID: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case authorUID
        case createdAt
    }
}
