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
    
    // 초대코드 발급 버튼
    let inviteCodeButton = UIButton().then { $0.backgroundColor = UIColor.mainSub2?.withAlphaComponent(0.5) }
    let inviteCodeImage = UIImageView().then { $0.image = UIImage(named: "inviteCode") }
    let inviteCodeLabel = UILabel().then {
        $0.text = "초대 코드 발급"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 약속 카테고리
    let planLabel = UILabel().then {
        $0.text = "약속"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.purpleMain
    }
    
    // 대기중인 약속
    let waitingPlanTopBorder = Divider().then { $0.setColor(UIColor.gray100!) }
    let waitingPlanButton = UIButton().then { $0.backgroundColor = UIColor.clear }
    let waitingPlanLabel = UILabel().then {
        $0.text = "대기중인 약속"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 확정된 약속
    let decidedPlanTopBorder = Divider().then { $0.setColor(UIColor.gray100!) }
    let decidedPlanButton = UIButton().then { $0.backgroundColor = UIColor.clear }
    let decidedPlanLabel = UILabel().then {
        $0.text = "확정된 약속"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 지난 약속
    let pastPlanTopBorder = Divider().then { $0.setColor(UIColor.gray100!) }
    let pastPlanButton = UIButton().then { $0.backgroundColor = UIColor.clear }
    let pastPlanLabel = UILabel().then {
        $0.text = "지난 약속"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textHigh
    }
    let pastPlanBottomBorder = Divider().then { $0.setColor(UIColor.gray100!) }
    
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
        inviteCodeConstraints()
        planConstraints()
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
    
    // 초대 코드 발급 Constrints
    private func inviteCodeConstraints() {
        sideBarBackground.addSubview(inviteCodeButton)
        inviteCodeButton.snp.makeConstraints { make in
            make.width.equalTo(sideBarBackground.snp.width)
            make.height.equalTo(50)
            make.top.equalTo(memberCountLabel.snp.bottom).offset(20)
        }
        
        inviteCodeButton.addSubview(inviteCodeImage)
        inviteCodeImage.snp.makeConstraints { make in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.centerY.equalTo(inviteCodeButton.snp.centerY)
            make.leading.equalTo(inviteCodeButton.snp.leading).offset(18)
        }
        
        inviteCodeButton.addSubview(inviteCodeLabel)
        inviteCodeLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(inviteCodeButton.snp.centerY)
            make.leading.equalTo(inviteCodeImage.snp.trailing).offset(6)
        }
    }
    
    // 약속 Constraints
    private func planConstraints() {
        sideBarBackground.addSubview(planLabel)
        planLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(inviteCodeButton.snp.bottom).offset(30)
            make.leading.equalTo(sideBarBackground.snp.leading).offset(18)
        }
        
        // 대기중인 약속
        sideBarBackground.addSubview(waitingPlanTopBorder)
        waitingPlanTopBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(planLabel.snp.bottom).offset(16)
        }
        
        sideBarBackground.addSubview(waitingPlanButton)
        waitingPlanButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(planLabel.snp.bottom).offset(16)
        }
        
        waitingPlanButton.addSubview(waitingPlanLabel)
        waitingPlanLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(waitingPlanButton.snp.centerY)
            make.leading.equalTo(waitingPlanButton.snp.leading).offset(20)
        }
        
        // 확정된 약속
        sideBarBackground.addSubview(decidedPlanTopBorder)
        decidedPlanTopBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(waitingPlanButton.snp.bottom)
        }
        
        sideBarBackground.addSubview(decidedPlanButton)
        decidedPlanButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(waitingPlanButton.snp.bottom)
        }
        
        decidedPlanButton.addSubview(decidedPlanLabel)
        decidedPlanLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(decidedPlanButton.snp.centerY)
            make.leading.equalTo(decidedPlanButton.snp.leading).offset(20)
        }
        
        // 지난 약속
        sideBarBackground.addSubview(pastPlanTopBorder)
        pastPlanTopBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(decidedPlanButton.snp.bottom)
        }
        
        sideBarBackground.addSubview(pastPlanButton)
        pastPlanButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(decidedPlanButton.snp.bottom)
        }
        
        pastPlanButton.addSubview(pastPlanLabel)
        pastPlanLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(pastPlanButton.snp.centerY)
            make.leading.equalTo(pastPlanButton.snp.leading).offset(20)
        }
        
        sideBarBackground.addSubview(pastPlanBottomBorder)
        pastPlanBottomBorder.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(sideBarBackground.snp.width)
            make.top.equalTo(pastPlanButton.snp.bottom)
        }
    }
}

class Divider: UIView {
    let divider = UIView().then {
        $0.backgroundColor = UIColor.black
//        $0.backgroundColor = UIColor.gray100
    }
    
    // Custom View 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // 구성 요소들을 Custom View에 추가하고 레이아웃 설정
    private func setupViews() {
        addSubview(divider)
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
    }
    
    func setColor(_ color: UIColor) {
        divider.backgroundColor = color
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
