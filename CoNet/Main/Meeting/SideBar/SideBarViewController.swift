//
//  SideBarViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/20.
//

import SnapKit
import Then
import UIKit

protocol SideBarListButtonDelegate: AnyObject {
    func sideBarListButtonTapped(title: SideBarMenu)
}

class SideBarViewController: UIViewController, SideBarListButtonDelegate {
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
    
    // 약속 카테고리 - 대기중인 약속, 확정된 약속, 지난 약속
    let planLabel = UILabel().then {
        $0.text = "약속"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.purpleMain
    }
    let waitingPlanButton = SideBarList().then { $0.setTitle("대기중인 약속") }
    let decidedPlanButton = SideBarList().then { $0.setTitle("확정된 약속") }
    let pastPlanButton = SideBarList().then {
        $0.setTitle("지난 약속")
        $0.setBottomBorder()
    }

    // 히스토리 카테고리
    let historyLabel = UILabel().then {
        $0.text = "히스토리"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.purpleMain
    }
    
    // 히스토리
    let historyButton = SideBarList().then {
        $0.setTitle("히스토리")
        $0.setBottomBorder()
    }
    
    // 하단 divider
    let bottomButtonDivider = Divider().then { $0.setColor(UIColor.gray100!) }
    let bottomVerticalDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    // 모임 삭제
    let deleteMeetingButton = UIButton().then { $0.backgroundColor = .clear }
    let deleteMeetingImage = UIImageView().then { $0.image = UIImage(named: "deleteMeeting") }
    let deleteMeetingButtonTitle = UILabel().then {
        $0.text = "모임 삭제"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 모임 나가기
    let leaveMeetingButton = UIButton().then { $0.backgroundColor = .clear }
    let leaveMeetingImage = UIImageView().then { $0.image = UIImage(named: "leaveMeeting") }
    let leaveMeetingButtonTitle = UILabel().then {
        $0.text = "모임 나가기"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.error
    }
    
    // MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 clear로 설정 (default: black)
        view.backgroundColor = .clear
        
        layoutConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
        
        buttonsDelegate()
    }
    
    func buttonsDelegate() {
        waitingPlanButton.delegate = self
        decidedPlanButton.delegate = self
        pastPlanButton.delegate = self
        historyButton.delegate = self
    }
    
    // 배경 탭 시 팝업 닫기
    @objc func dismissPopUp() {
        dismiss(animated: true)
    }
    
    weak var delegate: ModalViewControllerDelegate?

    // 이전 ViewController에 값을 전달하는 동작
    func sendDataToPreviousViewController(title: SideBarMenu) {
        delegate?.sendDataBack(data: title)
    }
    
    func sideBarListButtonTapped(title: SideBarMenu) {
        dismiss(animated: true) {
            self.sendDataToPreviousViewController(title: title)
        }
    }
    
    // 모든 layout Constraints
    private func layoutConstraints() {
        backgroundConstraints()
        meetingInfoConstraints()
        inviteCodeConstraints()
        planConstraints()
        historyConstraints()
        bottomButtonsConstraints()
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
            make.width.height.equalTo(16)
            make.centerY.equalTo(meetingNameLabel.snp.centerY)
            make.leading.equalTo(meetingNameLabel.snp.trailing).offset(8)
        }
        
        sideBarBackground.addSubview(memberCountImage)
        memberCountImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
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
            make.width.height.equalTo(24)
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
        sideBarBackground.addSubview(waitingPlanButton)
        waitingPlanButton.snp.makeConstraints { make in
            listConstraints(make: make, previousView: planLabel, isFirstList: true)
        }
        
        // 확정된 약속
        sideBarBackground.addSubview(decidedPlanButton)
        decidedPlanButton.snp.makeConstraints { make in
            listConstraints(make: make, previousView: waitingPlanButton, isFirstList: false)
        }
        
        // 지난 약속
        sideBarBackground.addSubview(pastPlanButton)
        pastPlanButton.snp.makeConstraints { make in
            listConstraints(make: make, previousView: decidedPlanButton, isFirstList: false)
        }
    }
    
    // 히스토리 Constraints
    private func historyConstraints() {
        sideBarBackground.addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(pastPlanButton.snp.bottom).offset(30)
            make.leading.equalTo(sideBarBackground.snp.leading).offset(18)
        }
        
        // 히스토리
        sideBarBackground.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            listConstraints(make: make, previousView: historyLabel, isFirstList: true)
        }
    }
    
    // 모임 나가기, 탈퇴 Constraints
    private func bottomButtonsConstraints() {
        sideBarBackground.addSubview(bottomButtonDivider)
        bottomButtonDivider.snp.makeConstraints { make in
            make.width.equalTo(sideBarBackground.snp.width)
            make.height.equalTo(1)
            make.bottom.equalTo(sideBarBackground.snp.bottom).offset(-96)
        }
        
        // 모임 삭제
        sideBarBackground.addSubview(deleteMeetingButton)
        deleteMeetingButton.snp.makeConstraints { make in
            make.width.equalTo(sideBarBackground.snp.width).dividedBy(2)
            make.height.equalTo(60)
            make.leading.equalTo(sideBarBackground.snp.leading)
            make.bottom.equalTo(sideBarBackground.snp.bottom).offset(-36)
        }
        
        deleteMeetingButton.addSubview(deleteMeetingButtonTitle)
        deleteMeetingButtonTitle.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.centerY.equalTo(deleteMeetingButton.snp.centerY)
            make.trailing.equalTo(deleteMeetingButton.snp.trailing).offset(-30)
        }
        
        deleteMeetingButton.addSubview(deleteMeetingImage)
        deleteMeetingImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(deleteMeetingButtonTitle.snp.centerY)
            make.trailing.equalTo(deleteMeetingButtonTitle.snp.leading).offset(-2)
        }
        
        // 모임 나가기
        sideBarBackground.addSubview(leaveMeetingButton)
        leaveMeetingButton.snp.makeConstraints { make in
            make.width.equalTo(sideBarBackground.snp.width).dividedBy(2)
            make.height.equalTo(60)
            make.trailing.equalTo(sideBarBackground.snp.trailing)
            make.bottom.equalTo(sideBarBackground.snp.bottom).offset(-36)
        }
        
        leaveMeetingButton.addSubview(leaveMeetingImage)
        leaveMeetingImage.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(leaveMeetingButton.snp.centerY)
            make.leading.equalTo(leaveMeetingButton.snp.leading).offset(30)
        }
        
        leaveMeetingButton.addSubview(leaveMeetingButtonTitle)
        leaveMeetingButtonTitle.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.centerY.equalTo(leaveMeetingButton)
            make.leading.equalTo(leaveMeetingImage.snp.trailing).offset(2)
        }
        
        sideBarBackground.addSubview(bottomVerticalDivider)
        bottomVerticalDivider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(30)
            make.centerX.equalTo(sideBarBackground.snp.centerX)
            make.centerY.equalTo(deleteMeetingButton.snp.centerY)
        }
    }
    
    // 메뉴 리스트 공통 constraints
    private func listConstraints(make: ConstraintMaker, previousView: UIView, isFirstList: Bool) {
        make.height.equalTo(50)
        make.width.equalTo(sideBarBackground.snp.width)
        make.top.equalTo(previousView.snp.bottom).offset(isFirstList ? 16 : 0)
    }
}
