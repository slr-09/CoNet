//
//  TimeAPI.swift
//  CoNet
//
//  Created by 가은 on 2023/08/07.
//

import Alamofire
import Foundation
import KeychainSwift

class PlanTimeAPI {
    let baseUrl = "http://15.164.196.172:9000"
    
    // 구성원의 가능한 시간 조회 
    func getMemberPossibleTime(planId: Int, completion: @escaping (_ teamId: Int, _ planId: Int, _ planName: String, _ planStartPeriod: String, _ planEndPeriod: String, _ possibleMemberDateTime: [PossibleMemberDateTime]) -> Void) {
        let url = "\(baseUrl)/team/plan/member-time?planId=\(planId)"
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(keychain.get("accessToken") ?? "")"
        ]

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<GetMemberPossibleTimeResult>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let result = response.result else { return }
                    print("DEBUG(getMemberPossibleTime api): \(result)")
                    
                    completion(result.teamId, result.planId, result.planName, result.planStartPeriod, result.planStartPeriod, result.possibleMemberDateTime)

                case .failure(let error):
                    print("DEBUG(getMemberPossibleTime api) error: \(error)")
                }
            }
    }
}
