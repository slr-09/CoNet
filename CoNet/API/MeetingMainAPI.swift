//
//  MeetingMainAPI.swift
//  CoNet
//
//  Created by 가은 on 2023/08/06.
//

import Alamofire
import Foundation
import KeychainSwift

class MeetingMainAPI {
    let baseUrl = "http://15.164.196.172:9000"

    // 팀 내 특정 달 약속 조회
    func getMeetingMonthPlan(teamId: Int, searchDate: String, completion: @escaping (_ count: Int, _ dates: [Int]) -> Void) {
        let url = "\(baseUrl)/team/plan/month?teamId=\(teamId)&searchDate=\(searchDate)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetMonthPlanResult>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let result = response.result else { return }
                    print("DEBUG(get meeting month plan api): \(result)")
                    completion(result.count, result.dates)

                case .failure(let error):
                    print("DEBUG(get meeting month plan api) error: \(error)")
                }
            }
    }
    
    // 팀 내 특정 날짜 약속 조회
    func getMeetingDayPlan(teamId: Int, searchDate: String, completion: @escaping (_ count: Int, _ plans: [Plan]) -> Void) {
        let url = "\(baseUrl)/team/plan/day?teamId=\(teamId)&searchDate=\(searchDate)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetDayPlanResult>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let result = response.result else { return }
                    print("DEBUG(get meeting day plan api): \(result)")
                    completion(result.count, result.plans)

                case .failure(let error):
                    print("DEBUG(get meeting day plan api) error: \(error)")
                }
            }
    }
    
}
