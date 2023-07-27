//
//  MeetingDelPopUpViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/26.
//

import SnapKit
import Then
import UIKit

class MeetingDelPopUpViewController: UIViewController {
    
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    let popUpView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 10
    }
    let meetingDelLabel = UILabel().then {
        $0.text = "모임을 삭제하시겠습니까?"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.black
        $0.adjustsFontSizeToFitWidth = true
    }
    let meetingDelLabel2 = UILabel().then {
        $0.text = "삭제된 모임 내 기록은 복구되지 않습니다."
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textHigh
    }
    let horizontalDivider = UIView().then {
        $0.backgroundColor = UIColor.gray100
    }
    let verticalDivider = UIView().then {
        $0.backgroundColor = UIColor.gray100
    }
    let cancelButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    let cancelLabel = UILabel().then {
        $0.text = "취소"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textMedium
    }
    let delButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    let delLabel = UILabel().then {
        $0.text = "삭제"
        $0.font = UIFont.body1Bold
        $0.textColor = UIColor.purpleMain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(background)
        self.view.addSubview(popUpView)
        self.view.addSubview(meetingDelLabel)
        self.view.addSubview(meetingDelLabel2)
        self.view.addSubview(horizontalDivider)
        self.view.addSubview(verticalDivider)
        self.view.addSubview(cancelButton)
        self.view.addSubview(cancelLabel)
        self.view.addSubview(delButton)
        self.view.addSubview(delLabel)
        applyConstraintsToComponents()
        applyConstraintsTobackground()
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        delButton.addTarget(self, action: #selector(outButtonTapped), for: .touchUpInside)
    }
    
    func applyConstraintsToComponents() {
        let safeArea = view.safeAreaLayoutGuide
        
        popUpView.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(179)
            make.top.equalTo(safeArea.snp.top).offset(293)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        meetingDelLabel.snp.makeConstraints { make in
            make.top.equalTo(popUpView.snp.top).offset(39)
            make.leading.equalTo(popUpView.snp.leading).offset(82)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-83)
        }
        meetingDelLabel2.snp.makeConstraints { make in
            make.top.equalTo(meetingDelLabel.snp.bottom).offset(11)
            make.leading.equalTo(popUpView.snp.leading).offset(57)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-57)
        }
        horizontalDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(meetingDelLabel2.snp.bottom).offset(30)
            make.leading.equalTo(popUpView.snp.leading).offset(0)
            make.trailing.equalTo(popUpView.snp.trailing).offset(0)
        }
        verticalDivider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(24)
            make.top.equalTo(horizontalDivider.snp.bottom).offset(18)
            make.centerX.equalTo(popUpView)
        }
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(172)
            make.height.equalTo(60)
            make.top.equalTo(meetingDelLabel2.snp.bottom).offset(31)
            make.leading.equalTo(popUpView).offset(0)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-173)
        }
        cancelLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top).offset(18)
            make.leading.equalTo(cancelButton.snp.leading).offset(72)
        }
        delButton.snp.makeConstraints { make in
            make.width.equalTo(172)
            make.height.equalTo(60)
            make.top.equalTo(meetingDelLabel2.snp.bottom).offset(31)
            make.leading.equalTo(popUpView).offset(173)
            make.trailing.equalTo(popUpView.snp.trailing).offset(0)
        }
        delLabel.snp.makeConstraints { make in
            make.top.equalTo(delButton.snp.top).offset(20)
            make.leading.equalTo(delButton.snp.leading).offset(72)
        }
    }
    
    func applyConstraintsTobackground() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func outButtonTapped() {
        
    }
}
