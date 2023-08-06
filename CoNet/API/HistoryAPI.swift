//
//  HistoryAPI.swift
//  CoNet
//
//  Created by 이안진 on 2023/08/06.
//

import Alamofire
import Foundation
import KeychainSwift
import UIKit

struct GetHistoryResult: Codable {
    let planId: Int
    let planName, planDate: String
    let planMemberNum: Int
    let historyImgUrl, historyDescription: String?
}

class HistoryAPI {
    let keychain = KeychainSwift()
    let baseUrl = "http://15.164.196.172:9000"
    
    // 히스토리 조회
    func getHistory(meetingId: Int, completion: @escaping (_ histories: [GetHistoryResult]) -> Void) {
        let url = "\(baseUrl)/history?teamId=\(meetingId)"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: BaseResponse<[GetHistoryResult]>.self) { response in
                switch response.result {
                case .success(let response):
                    guard let serverHistories = response.result else { return }
                    print("DEBUG(히스토리 조회 api) history: \(serverHistories)")
                    completion(serverHistories)
                    
                case .failure(let error):
                    print("DEBUG(히스토리 조회 api) error: \(error)")
                }
            }
    }
}
