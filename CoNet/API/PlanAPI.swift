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
    let members: [String]
    let membersID: [Int]
    let isRegisteredToHistory: Bool
    let historyImgURL, historyDescription: String?
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
    func getPlanDetail(planId: Int, completion: @escaping (_ plans: [PlanDetail]) -> Void) {
        let url = "\(baseUrl)/team/plan/detail?planId=\(planId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[PlanDetail]>.self) { response in
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
}
