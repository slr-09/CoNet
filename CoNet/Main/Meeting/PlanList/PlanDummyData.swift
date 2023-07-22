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

struct DecidedPlan {
    let date: String
    let time: String
    let title: String
    let leftDate: String
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
    
    static let decidedPlanData: [DecidedPlan] = [
        DecidedPlan(date: "2023. 07. 08", time: "14:00", title: "iOS 1차 스터디", leftDate: "3일 남았습니다."),
        DecidedPlan(date: "2023. 07. 11", time: "16:00", title: "Android 2차 스터디입니다요 우하하", leftDate: "6일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다."),
        DecidedPlan(date: "2023. 07. 12", time: "15:00", title: "Server 3차 스터디입니다요 우하하흐하", leftDate: "7일 남았습니다.")]
}
