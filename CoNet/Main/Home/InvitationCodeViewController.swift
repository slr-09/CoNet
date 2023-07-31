//
//  invitationCodeViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/20.
//

import SnapKit
import Then
import UIKit

class InvitationCodeViewController: UIViewController {
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    let popUpView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    let xButton = UIButton().then {
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }
    let inviteLabel = UILabel().then {
        $0.text = "초대코드가\n발급되었어요."
        $0.font = UIFont.headline2Bold
        $0.textColor = UIColor.black
        $0.numberOfLines = 2
    }
    let codeLabel = UILabel().then {
        $0.text = "Xy3zE56j"
        $0.font = UIFont.body1Medium
        $0.tintColor = UIColor.black
    }
    let purpleLine = UIView().then {
        $0.backgroundColor = UIColor.purpleMain
    }
    let infoLabel = UILabel().then {
        $0.text = "초대 코드 유효 기간 : 2023. 07. 17. 21:32"
        $0.textColor = .textMedium
        $0.font = UIFont.overline
        $0.numberOfLines = 0
    }
    let sendButton = UIButton().then {
        $0.backgroundColor = UIColor.purpleMain
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("보내기", for: .normal)
        $0.titleLabel?.font = UIFont.body1Medium
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        
        self.view.addSubview(background)
        self.view.addSubview(popUpView)
        self.view.addSubview(xButton)
        self.view.addSubview(inviteLabel)
        self.view.addSubview(codeLabel)
        self.view.addSubview(purpleLine)
        self.view.addSubview(infoLabel)
        self.view.addSubview(sendButton)
        applyConstraintsToComponents()
        
        // sendButton.addTarget(self, action: #selector(participateButtonTapped), for: .touchUpInside)
    }
    
    func applyConstraintsToComponents() {
        let safeArea = view.safeAreaLayoutGuide
        
        popUpView.snp.makeConstraints { make in
            make.width.equalTo(257)
            make.height.equalTo(332)
            make.top.equalTo(view.snp.top).offset(260)
            make.leading.equalTo(safeArea.snp.leading).offset(68)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-68)
        }
        xButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(popUpView.snp.top).offset(18)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-18)
        }
        inviteLabel.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.top.equalTo(popUpView.snp.top).offset(66)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.trailing.equalTo(popUpView.snp.trailing).offset(66)
        }
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(inviteLabel.snp.bottom).offset(66)
            make.centerX.equalTo(purpleLine)
        }
        purpleLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(inviteLabel.snp.bottom).offset(96)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-33)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(purpleLine.snp.bottom).offset(4)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
        }
        sendButton.snp.makeConstraints { make in
            make.width.equalTo(191)
            make.height.equalTo(54)
            make.top.equalTo(purpleLine.snp.bottom).offset(32)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-33)
        }
    }
    
    func applyConstraintsTobackground() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
}
#if canImport(SwiftUI) && DEBUG
 import SwiftUI

 struct ViewControllerPreview: PreviewProvider {
     static var previews: some View {
         InvitationCodeViewController().showPreview(.iPhone14Pro)
     }
 }
 #endif
