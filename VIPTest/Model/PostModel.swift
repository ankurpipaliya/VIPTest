//
//  PostModel.swift
//  VIPTest
//
//  Created by AnkurPipaliya on 12/07/23.
//

import Foundation

public struct PostModel: Codable
{
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
