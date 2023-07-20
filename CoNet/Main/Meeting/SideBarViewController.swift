//
//  SideBarViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/20.
//

import SnapKit
import Then
import UIKit

class SideBarViewController: UIViewController {
    // 배경 - black 투명도 30%
    let background = UIView().then { $0.backgroundColor = UIColor.black.withAlphaComponent(0.5) }
    
    // 사이드 바 하얀 배경
    let sideBarBackground = UIView().then { $0.backgroundColor = UIColor.grayWhite }
    
    // 닫기 버튼
    let closeButton = UIButton().then { $0.setImage(UIImage(named: "closeBtn"), for: .normal) }
    
    // 모임정보 - 모임 이름, 모임 정보 수정 버튼, 모임 멤버 수 아이콘, 모임 멤버 수
    var meetingNameLabel = UILabel().then {
        $0.text = "CoNet"
        $0.font = UIFont.headline1
        $0.textColor = UIColor.textHigh
    }
    let editMeetingInfoButton = UIButton().then { $0.setImage(UIImage(named: "editMeetingInfo"), for: .normal)}
    let memberCountImage = UIImageView().then { $0.image = UIImage(named: "meetingMember") }
    var memberCountLabel = UILabel().then {
        $0.text = "9명"
        $0.font = UIFont.body3Medium
        $0.textColor = UIColor.textMedium
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 clear로 설정 (default: black)
        view.backgroundColor = .clear
        
        layoutConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
    }
    
    // 배경 탭 시 팝업 닫기
    @objc func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
    
    // 모든 layout Constraints
    private func layoutConstraints() {
        backgroundConstraints()
        meetingInfoConstraints()
    }
    
    // 배경 Constraints
    private func backgroundConstraints() {
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        
        view.addSubview(sideBarBackground)
        sideBarBackground.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(view.snp.leading).offset(120)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        sideBarBackground.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalTo(sideBarBackground.snp.top).offset(50)
            make.trailing.equalTo(sideBarBackground.snp.trailing).offset(-20)
        }
    }
    
    // 모임 정보 Constraints
    private func meetingInfoConstraints() {
        sideBarBackground.addSubview(meetingNameLabel)
        meetingNameLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(closeButton.snp.bottom).offset(36)
            make.leading.equalTo(sideBarBackground.snp.leading).offset(18)
        }
        
        sideBarBackground.addSubview(editMeetingInfoButton)
        editMeetingInfoButton.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.centerY.equalTo(meetingNameLabel.snp.centerY)
            make.leading.equalTo(meetingNameLabel.snp.trailing).offset(8)
        }
        
        sideBarBackground.addSubview(memberCountImage)
        memberCountImage.snp.makeConstraints { make in
            make.width.equalTo(12)
            make.height.equalTo(12)
            make.top.equalTo(meetingNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(sideBarBackground.snp.leading).offset(18)
        }
        
        sideBarBackground.addSubview(memberCountLabel)
        memberCountLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.centerY.equalTo(memberCountImage.snp.centerY)
            make.leading.equalTo(memberCountImage.snp.trailing).offset(4)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        SideBarViewController().showPreview(.iPhone14Pro)
    }
}
#endif
