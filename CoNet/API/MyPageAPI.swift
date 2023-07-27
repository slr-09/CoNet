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
    
    func getUser(completion: @escaping (_ name: String, _ imageUrl: String, _ email: String, _ social: String) -> Void) {
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
                print("DEBUG(getUser) imageUrl: \(response.result?.imageUrl ?? "url 없음")")
                
                guard let result = response.result else { return }
                
                let name = result.name
                let imageUrl = result.imageUrl
                let email = result.email
                let social = result.social
                
                completion(name, imageUrl, email, social)
                
            case .failure(let error):
                print("DEBUG(get user api) error: \(error)")
            }
        }
    }
    
    // 회원 탈퇴
    func signout(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/user/delete"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url,
                   method: .post,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseDecodable(of: BaseResponse<String>.self) { response in
            switch response.result {
            case .success(let response):
                print("DEBUG(signout api) result: \(response.result ?? "뭔가 문제가 있다")")
                completion(true)
            case .failure(let error):
                print("DEBUG(signout api) error: \(error)")
                completion(false)
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
