//
//  Meeting.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/31.
//

import Foundation

struct PostMeetingInviteCodeResponse: Codable {
    let teamId: Int
    let inviteCode, codeDeadLine: String
}

struct GetMeetingDetailInfoResponse: Codable {
    let teamName, teamImgUrl: String
    let teamMemberCount: Int
    let isNew: Bool?
    let bookmark: Bool
}

struct Meeting {
    let name, imgUrl: String
    let memberCount: Int
    let bookmark: Bool
}
