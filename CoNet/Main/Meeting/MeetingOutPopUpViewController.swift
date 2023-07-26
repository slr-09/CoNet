//
//  MeetingOutPopUpViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/26.
//

import SnapKit
import Then
import UIKit

class MeetingOutPopUpViewController: UIViewController {
    
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    let popUpView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 10
    }
    let meetingOutLabel = UILabel().then {
        $0.text = "모임을 나가시겠습니까?"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.black
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
    let outButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    let outLabel = UILabel().then {
        $0.text = "나가기"
        $0.font = UIFont.body1Bold
        $0.textColor = UIColor.purpleMain
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(background)
        self.view.addSubview(popUpView)
        self.view.addSubview(meetingOutLabel)
        self.view.addSubview(horizontalDivider)
        self.view.addSubview(verticalDivider)
        self.view.addSubview(cancelButton)
        self.view.addSubview(cancelLabel)
        self.view.addSubview(outButton)
        self.view.addSubview(outLabel)
        applyConstraintsToComponents()
        applyConstraintsTobackground()
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        outButton.addTarget(self, action: #selector(outButtonTapped), for: .touchUpInside)
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
        meetingOutLabel.snp.makeConstraints { make in
            make.top.equalTo(popUpView.snp.top).offset(54)
            make.leading.equalTo(popUpView.snp.leading).offset(83)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-82)
        }
        horizontalDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(meetingOutLabel.snp.bottom).offset(42)
            make.leading.equalTo(popUpView.snp.leading).offset(0)
            make.trailing.equalTo(popUpView.snp.trailing).offset(0)
        }
        verticalDivider.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.height.equalTo(24)
            make.top.equalTo(horizontalDivider.snp.bottom).offset(16)
            make.centerX.equalTo(popUpView)
        }
        cancelButton.snp.makeConstraints { make in
            make.width.equalTo(172)
            make.height.equalTo(60)
            make.top.equalTo(meetingOutLabel.snp.bottom).offset(43)
            make.leading.equalTo(popUpView).offset(0)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-173)
        }
        cancelLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top).offset(18)
            make.leading.equalTo(cancelButton.snp.leading).offset(72)
        }
        outButton.snp.makeConstraints { make in
            make.width.equalTo(172)
            make.height.equalTo(60)
            make.top.equalTo(meetingOutLabel.snp.bottom).offset(43)
            make.leading.equalTo(popUpView).offset(173)
            make.trailing.equalTo(popUpView.snp.trailing).offset(0)
        }
        outLabel.snp.makeConstraints { make in
            make.top.equalTo(outButton.snp.top).offset(20)
            make.leading.equalTo(outButton.snp.leading).offset(66)
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
