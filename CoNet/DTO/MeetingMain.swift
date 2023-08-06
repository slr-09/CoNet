//
//  MeetingMain.swift
//  CoNet
//
//  Created by 가은 on 2023/08/06.
//

import Foundation

// 팀 내 특정 달 약속 조회
struct GetMeetingMonthPlanResult: Codable {
    let count: Int
    let dates: [Int]
}
