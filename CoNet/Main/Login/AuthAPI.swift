//
//  AuthApi.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/05.
//

import Alamofire
import Foundation
import KeychainSwift

class AuthAPI {
    let keychain = KeychainSwift()
    let baseUrl = "http://15.164.196.172:9000"
    
    func regenerateToken(completion: @escaping (String) -> Void) {
        let url = "\(baseUrl)/auth/regenerate-token"
        let parameters: [String: Any] = [
            "refreshToken": keychain.get("refreshToken") ?? ""
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: PostRegenerateTokenResponse.self) { response in
            switch response.result {
            case .success(let response):
                self.keychain.set(response.result.accessToken,
                                  forKey: "accessToken")
                self.keychain.set(response.result.refreshToken,
                                  forKey: "refreshToken")
                print("DEBUG(regenerate api) accessToken: \(response.result.accessToken)")
                print("DEBUG(regenerate api) refreshToken: \(response.result.refreshToken)")
            case .failure(let error):
                print("DEBUG(regenerate api) error: \(error)")
            }
        }
    }
    
    func login() {
        
    }
}
