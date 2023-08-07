//
//  PlanAPI.swift
//  CoNet
//
//  Created by 이안진 on 2023/08/05.
//

import Alamofire
import Foundation
import KeychainSwift
import UIKit

struct GetPlansAtMeetingResult<T: Codable>: Codable {
    let count: Int
    let plans: T?
}

struct WaitingPlanInfo: Codable {
    let planId: Int
    let startDate, endDate, planName: String
    let teamName: String?
}

struct DecidedPlanInfo: Codable {
    let planId: Int
    let date, time: String
    let teamName: String?
    let planName: String
    let dday: Int
}

struct PastPlanInfo: Codable {
    let planId: Int
    let date, time, planName: String
    let isRegisteredToHistory: Bool
}

struct PlanDetail: Codable {
    let planId: Int
    let planName, date, time: String
    let members: [PlanDetailMember]
    let isRegisteredToHistory: Bool
    let historyImgUrl, historyDescription: String?
}

struct PlanDetailMember: Codable {
    let id: Int
    let name, image: String
}

struct PlanEditResponse: Codable {
    let code, status: Int
    let message, result: String
}

struct CreatePlanResponse: Codable {
    let code, status: Int
    let message: String
    let result: Result
}

struct Result: Codable {
    let planID: Int

    enum CodingKeys: String, CodingKey {
        case planID = "planId"
    }
}

class PlanAPI {
    let keychain = KeychainSwift()
    let baseUrl = "http://15.164.196.172:9000"
    
    // 팀 내 대기중인 약속 조회
    func getWaitingPlansAtMeeting(meetingId: Int, completion: @escaping (_ count: Int, _ plans: [WaitingPlanInfo]) -> Void) {
        let url = "\(baseUrl)/team/plan/waiting?teamId=\(meetingId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetPlansAtMeetingResult<[WaitingPlanInfo]>>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let count = response.result?.count else { return }
                    guard let serverPlans = response.result?.plans else { return }
                    completion(count, serverPlans)
                    
                case .failure(let error):
                    print("DEBUG(팀 내 대기 중인 약속 api) error: \(error)")
                }
            }
    }
    
    // 팀 내 확정된 약속 조회
    func getDecidedPlansAtMeeting(meetingId: Int, completion: @escaping (_ count: Int, _ plans: [DecidedPlanInfo]) -> Void) {
        let url = "\(baseUrl)/team/plan/fixed?teamId=\(meetingId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[DecidedPlanInfo]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let count = response.result?.count else { return }
                    guard let serverPlans = response.result else { return }
                    completion(count, serverPlans)
                    
                case .failure(let error):
                    print("DEBUG(팀 내 확정된 약속 api) error: \(error)")
                }
            }
    }
    
    // 팀 내 지난 약속 조회
    func getPastPlansAtMeeting(meetingId: Int, completion: @escaping (_ count: Int, _ plans: [PastPlanInfo]) -> Void) {
        let url = "\(baseUrl)/team/plan/past?teamId=\(meetingId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[PastPlanInfo]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let count = response.result?.count else { return }
                    guard let serverPlans = response.result else { return }
                    print(serverPlans)
                    completion(count, serverPlans)
                    
                case .failure(let error):
                    print("DEBUG(팀 내 지난 약속 api) error: \(error)")
                }
            }
    }
    
    // 팀 내 지난 약속 조회
    func getUnRegisteredPastPlansAtMeeting(meetingId: Int, completion: @escaping (_ plans: [PastPlanInfo]) -> Void) {
        let url = "\(baseUrl)/team/plan/non-history?teamId=\(meetingId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[PastPlanInfo]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let serverPlans = response.result else { return }
                    print(serverPlans)
                    completion(serverPlans)
                    
                case .failure(let error):
                    print("DEBUG(팀 내 지난 약속 api) error: \(error)")
                }
            }
    }
    
    // 약속 상세 정보 조회
    func getPlanDetail(planId: Int, completion: @escaping (_ plans: PlanDetail) -> Void) {
        let url = "\(baseUrl)/team/plan/detail?planId=\(planId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<PlanDetail>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let serverPlans = response.result else { return }
                    print(serverPlans)
                    completion(serverPlans)
                    
                case .failure(let error):
                    print("DEBUG(약속 상세 정보 조회 api) error: \(error)")
            }
        }
    }
    
    // 약속 상세 수정
    func updatePlan(planId: Int, planName: String, date: String?, time: String, members: [Int]?, isRegisteredToHistory: Bool, historyDescription: String?, image: UIImage, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/team/plan/update-fixed"
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        var requestBody: [String: Any] = [
            "planId": planId,
            "planName": planName,
            "time": time,
            "date": date,
            "members": members,
            "historyDescription": historyDescription,
            "isRegisteredToHistory": isRegisteredToHistory
        ]
        var requestBodyJson: String = ""
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    requestBodyJson = jsonString
                }
        } catch {
            print("Error encoding JSON: (error)")
        }
        
        guard let image = image.pngData() else { return }
        
        // Multipart Form 데이터 생성
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image, withName: "file", fileName: "\(image).png", mimeType: "image/png")
            multipartFormData.append(requestBodyJson.data(using: .utf8)!, withName: "request", mimeType: "application/json")
        }, to: url, method: .post, headers: headers)
            .responseDecodable(of: BaseResponse<PlanEditResponse>.self) { response in
                switch response.result {
                case .success(let response):
                    print("DEBUG(약속 상세 수정 api) success response: \(response)")
                    completion(response.code == 1000)
                    
                case .failure(let error):
                    print("DEBUG(약속 상세 수정 api) error: \(error)")
                }
            }
}

    func createPlan(teamId: Int, planName: String, planStartPeriod: String, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/team/plan/create"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]
        
        let parameters: Parameters = [
            "teamId": teamId,
            "planName": planName,
            "planStartPeriod": planStartPeriod
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseDecodable(of: BaseResponse<CreatePlanResponse>.self) { response in
            switch response.result {
            case .success(let response):
                print("DEBUG(약속 생성 api) success response: \(response)")
                completion(response.code == 1000)
                
            case .failure(let error):
                print("DEBUG(create plan api) error: \(error)")
            }
        }
    }

    // 약속 삭제
    func deletePlan(planId: Int, completion: @escaping (_ isSuccess: Bool) -> Void) {
        let url = "\(baseUrl)/team/plan/delete"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
        ]
        
        let parameters: Parameters = [
            "planId": planId
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .responseDecodable(of: BaseResponse<String>.self) { response in
            switch response.result {
            case .success(let response):
                print("DEBUG(약속 삭제 api) success response: \(response)")
                completion(response.code == 1000)
                
            case .failure(let error):
                print("DEBUG(약속 삭제 api) error: \(error)")
            }
        }
    }
}
    
