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
    
    // 모임 초대코드 발급
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
    
    // 모임 상세 정보 조회
    func getMeetingDetailInfo(teamId: Int, completion: @escaping (_ meeting: Meeting) -> Void) {
        let url = "\(baseUrl)/team/detail?teamId=\(teamId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetMeetingDetailInfoResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let name = response.result?.teamName else { return }
                    guard let imgUrl = response.result?.teamImgUrl else { return }
                    guard let count = response.result?.teamMemberCount else { return }
                    guard let bookmark = response.result?.bookmark else { return }
                    
                    let meeting = Meeting(name: name, imgUrl: imgUrl, memberCount: count, bookmark: bookmark)
                    completion(meeting)
                    
                case .failure(let error):
                    print("DEBUG(edit name api) error: \(error)")
                }
            }
    }
}
