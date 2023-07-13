//
//  Login.swift
//  CoNet
//
//  Created by 가은 on 2023/07/13.
//

import Foundation

// apple login
struct PostAppleLoginResult: Codable {
    let email: String
    let accessToken: String
    let refreshToken: String
    let isRegistered: Bool
}
