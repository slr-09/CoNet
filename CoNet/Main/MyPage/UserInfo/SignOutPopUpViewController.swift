//
//  SignOutPopUpViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/20.
//

import SnapKit
import Then
import UIKit

/*
 override func viewDidLoad() {
    super.viewDidLoad()
    
    // 팝업 뷰 설정
    view.backgroundColor = UIColor.white
    view.layer.cornerRadius = 8.0
    
    // 배경에 탭 제스처 추가
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
    view.superview?.addGestureRecognizer(tapGesture)
}

@objc func backgroundTapped() {
    // 배경 탭 시 팝업 닫기
    dismiss(animated: true, completion: nil)
}
 */

class SignOutPopUpViewController: UIViewController {
    // 배경 - black 투명도 30%
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    // 팝업
    let popUp = PopUpView()
                    .withDescription(title: "탈퇴하시겠습니까?",
                                     description: "계정 내 참여한 모임, 약속이 모두 삭제되며\n복구되지 않습니다.",
                                     leftButtonTitle: "취소",
                                     leftButtonAction: #selector(dismissPopUp),
                                     rightButtonTitle: "탈퇴",
                                     rightButtonAction: #selector(dismissPopUp))

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
        popUpConstraints()
    }
    
    // 배경 Constraints
    private func backgroundConstraints() {
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    // 팝업 Constraints
    private func popUpConstraints() {
        view.addSubview(popUp)
        popUp.snp.makeConstraints { make in
            make.width.equalTo(view.snp.width).offset(-48)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.trailing.equalTo(view.snp.trailing).offset(24)
            
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
    
}

#if canImport(SwiftUI) && DEBUG
 import SwiftUI

 struct ViewControllerPreview: PreviewProvider {
     static var previews: some View {
         SignOutPopUpViewController().showPreview(.iPhone14Pro)
     }
 }
 #endif
