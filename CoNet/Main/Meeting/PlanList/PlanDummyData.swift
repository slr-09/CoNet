//
//  PlanDummyData.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/23.
//

import Foundation

struct WaitingPlan {
    let startDate: String
    let finishDate: String
    let title: String
}

struct PlanDummyData {
    static let watingPlanData: [WaitingPlan] = [
        WaitingPlan(startDate: "2023. 07. 02", finishDate: "2023. 07. 08", title: "iOS 스터디 1차"),
        WaitingPlan(startDate: "2023. 07. 11", finishDate: "2023. 07. 15", title: "Android 스터디 2차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "Server 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차인데 여러 줄이면 어떻게 되나"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차"),
        WaitingPlan(startDate: "2023. 07. 13", finishDate: "2023. 07. 19", title: "iOS 스터디 3차")]
}
