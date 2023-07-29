//
//  MyPageAPI.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/20.
//

import Alamofire
import UIKit
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
    
    // 프로필 이미지 수정
    func editProfileImage(image: UIImage, completion: @escaping (_ imageUrl: String) -> Void) {
        let url = "\(baseUrl)/user/image"
        let headers: HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        guard let image = image.pngData() else { return }
        
        // Multipart Form 데이터 생성
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "file", fileName: "\(image).png", mimeType: "image/png")
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: BaseResponse<PostEditProfileImageResponse>.self) { response in
            switch response.result {
            case .success(let response):
                guard let result = response.result else { return }
                completion(result.imgUrl)
                
            case .failure(let error):
                print("DEBUG(edit profile image api) error: \(error)")
            }
        }
    }
    
    // 이름 수정
    func editName(name: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/user/name"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let body: [String: Any] = [
            "name": name
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String>.self) { response in
                switch response.result {
                case .success(let response):
                    // 회원가입 성공 Bool 반환
                    completion(response.code == 1000)
                    
                case .failure(let error):
                    print("DEBUG(edit name api) error: \(error)")
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

struct PostEditProfileImageResponse: Codable {
    let name, imgUrl: String
}
