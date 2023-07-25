//
//  HomeAPI.swift
//  CoNet
//
//  Created by 가은 on 2023/07/25.
//

import Alamofire
import Foundation

class HomeAPI {
    let baseUrl = "http://15.164.196.172:9000"
    
    // 특정 달 약속 조회
    func getMonthPlan(date: String, completion: @escaping (_ count: Int, _ dates: [Int]) -> Void) {
        // 통신할 API 주소
        let url = "\(baseUrl)/home/month"
        
        // HTTP Headers : 요청 헤더
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        // request body
        let body: [String: Any] = [
            "searchDate": date
        ]
        
        // Request 생성
        let dataRequest = AF.request(url, method: .get, parameters: body, encoding: JSONEncoding.default, headers: headers)
        
        // responseData를 호출하면서 데이터 통신 시작
        // response에 데이터 통신의 결과가 담깁니다.
        dataRequest.responseDecodable(of: BaseResponse<GetMonthPlanResult>.self) { response in
            switch response.result {
            case .success(let response): // 성공한 경우에
                print(response.result ?? "result empty")
                
                guard let result = response.result else { return }
                
                let count = result.count
                let dates = result.dates
                
                completion(count, dates)
                
            case .failure(let error):
                print("DEBUG(apple login api) error: \(error)")
            }
        }
    }
}
