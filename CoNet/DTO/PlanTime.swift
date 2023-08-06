//
//  PlanTime.swift
//  CoNet
//
//  Created by 가은 on 2023/08/07.
//

import Foundation

// 구성원의 가능한 시간 조회
struct GetMemberPossibleTimeResult: Codable {
    let teamId, planId: Int
    let planName, planStartPeriod, planEndPeriod: String
    let possibleMemberDateTime: [PossibleMemberDateTime]
}

struct PossibleMemberDateTime: Codable {
    let date: String
    let possibleMember: [PossibleMember]
}

struct PossibleMember: Codable {
    let time: Int
    let section: Int
    let memberNames: [String]
    let memberIds: [Int]
}
