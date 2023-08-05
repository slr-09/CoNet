//
//  MeetingAPI.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/31.
//

import Alamofire
import Foundation
import KeychainSwift
import UIKit

struct PostCreateMeetingResponse: Codable {
    let teamId: Int
    let inviteCode: String
}

struct BadRequestResponse: Codable {
    let code, status: Int
    let message, timestamp: String
}

class MeetingAPI {
    let keychain = KeychainSwift()
    let baseUrl = "http://15.164.196.172:9000"
    
    // 모임 생성
    func createMeeting(name: String, image: UIImage, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/team/create"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let request = "{\"teamName\":\"\(name)\"}"
        guard let image = image.pngData() else { return }
        
        // Multipart Form 데이터 생성
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "file", fileName: "\(image).png", mimeType: "image/png")
            multipartFormData.append(request.data(using: .utf8)!, withName: "request", mimeType: "application/json")
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: BaseResponse<PostCreateMeetingResponse>.self) { response in
            switch response.result {
            case .success(let response):
                completion(response.code == 1000)
                
            case .failure(let error):
                print("DEBUG(create meeting api) error: \(error)")
            }
        }
    }
    
    // 모임 초대코드 발급
    func postParticipateMeeting(code: String, completion: @escaping (_ isSuccess: Bool, _ status: ParticipateMeetingStatus) -> Void) {
        let url = "\(baseUrl)/team/participate"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let body: [String: Any] = [
            "inviteCode": code
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                switch response.result {
                case .success:
                    let decoder = JSONDecoder()
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let data = response.value else { return }
                    switch statusCode {
                    case 200:
                        print("DEBUG 모임 참여 api: status 200")
                        completion(true, .valid)
                    default:
                        guard let data = try? decoder.decode(BadRequestResponse.self, from: data) else { return }
                        print("DEBUG 모임 참여 api message: \(data.message)")
                        switch data.code {
                        case 5501: completion(false, .isNotExist)
                        case 5502: completion(false, .expired)
                        case 5503: completion(false, .alreadyJoined)
                        default: completion(false, .invalidFormat)
                        }
                    }
                case .failure(let error):
                    print("DEBUG 모임 참여 api: \(error)")
                }
            }
    }
    
    // 모임 초대코드 발급
    func postMeetingInviteCode(teamId: Int, completion: @escaping (_ code: String, _ deadline: String) -> Void) {
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
                    completion(result.inviteCode, result.codeDeadLine)
                    
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
    
    // 북마크
    func postBookmark(teamId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/team/bookmark"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let body: [String: Any] = [
            "teamId": teamId
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String>.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response.code == 1000)
                    
                case .failure(let error):
                    print("DEBUG(edit name api) error: \(error)")
                }
            }
    }
    
    // 북마크 삭제
    func postDeleteBookmark(teamId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/team/bookmark/delete"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        let body: [String: Any] = [
            "teamId": teamId
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<String>.self) { response in
                switch response.result {
                case .success(let response):
                    completion(response.code == 1000)
                    
                case .failure(let error):
                    print("DEBUG(edit name api) error: \(error)")
                }
            }
    }
}
