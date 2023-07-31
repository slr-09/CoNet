//
//  MeetingAPI.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/31.
//

import Alamofire
import Foundation
import KeychainSwift

class MeetingAPI {
    let keychain = KeychainSwift()
    let baseUrl = "http://15.164.196.172:9000"
    
    func postMeetingInviteCode(teamId: Int, completion: @escaping (_ code: String) -> Void) {
        let url = "\(baseUrl)/team/code"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let body: [String: Any] = [
            "teamId": teamId
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<PostMeetingInviteCodeResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let result = response.result else { return }
                    completion(result.inviteCode)
                    
                case .failure(let error):
                    print("DEBUG(edit name api) error: \(error)")
                }
            }
    }
}
