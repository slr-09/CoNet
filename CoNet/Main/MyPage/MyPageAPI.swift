//
//  MyPageAPI.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/20.
//

import Alamofire
import Foundation
import KeychainSwift

class MyPageAPI {
    let keychain = KeychainSwift()
    let baseUrl = "http://15.164.196.172:9000"
    
    func getUser(completion: @escaping (_ name: String) -> Void) {
        let url = "\(baseUrl)/user"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url,
                   method: .get,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: BaseResponse<GetUserResponse>.self) { response in
            switch response.result {
            case .success(let response):
                print("DEBUG(getUser) code: \(response.code)")
                print("DEBUG(getUser) message: \(response.message)")
                print("DEBUG(getUser) name: \(response.result?.name ?? "이름 없음")")
                
                let name = response.result?.name ?? "api에서 이름 없음"
                completion(name)
                
            case .failure(let error):
                print("DEBUG(get user api) error: \(error)")
            }
        }
    }
}

struct GetUserResponse: Codable {
    let name, email, imageUrl, social: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case email = "email"
        case imageUrl = "userImgUrl"
        case social = "platform"
    }
}
