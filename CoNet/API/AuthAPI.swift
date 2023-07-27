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
    static let shared = AuthAPI()
    
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
    
    // MARK: apple login
    func appleLogin(completion: @escaping (_ isRegistered: Bool) -> Void) {
        // 통신할 API 주소
        let url = "\(baseUrl)/auth/login/apple"
        
        // HTTP Headers : 요청 헤더
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        // request body
        let body: [String: Any] = [
            "idToken": keychain.get("idToken") ?? ""
        ]
        
        // Request 생성
        let dataRequest = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
        
        // responseData를 호출하면서 데이터 통신 시작
        // response에 데이터 통신의 결과가 담깁니다.
        dataRequest.responseDecodable(of: BaseResponse<PostAppleLoginResult>.self) { response in
            switch response.result {
            case .success(let response):  // 성공한 경우에
                print(response.result ?? "result empty")
                
                // 사용자 정보 저장
                self.keychain.set(response.result!.email, forKey: "email")
                self.keychain.set(response.result!.accessToken, forKey: "accessToken")
                self.keychain.set(response.result!.refreshToken, forKey: "refreshToken")
                self.keychain.set(response.result!.isRegistered, forKey: "appleIsRegistered")
                completion(response.result!.isRegistered)
                
            case .failure(let error):
                print("DEBUG(apple login api) error: \(error)")
            }
        }
    }
    
    // MARK: kakao login
    func kakaoLogin(idToken: String) {
        let url = "\(baseUrl)/auth/login/kakao"
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let body: [String: Any] = [
            "idToken": idToken
        ]
        
        let dataRequest = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
        
        dataRequest.responseDecodable(of: BaseResponse<PostKakaoLoginResult>.self) { response in
            switch response.result {
            case .success(let response):
                print("DEBUG(kakao login) access token: \(response.result?.accessToken ?? "")")
                print("DEBUG(kakao login) refresh token: \(response.result?.refreshToken ?? "")")
                
                self.keychain.set(response.result!.email, forKey: "email")
                self.keychain.set(response.result!.email, forKey: "accessToken")
                self.keychain.set(response.result!.email, forKey: "kakaoIsRegistered")
                
            case .failure(let error):
                print("DEBUG(kakao login api) error: \(error)")
            }
        }
    }
}
