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

    override func viewDidLoad() {
        super.viewDidLoad()

        // background color를 clear로 설정 (default: black)
        view.backgroundColor = .clear
        
        backgroundConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        background.addGestureRecognizer(tapGesture)
    }
    
    // 배경 탭 시 팝업 닫기
    @objc func backgroundTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    // 배경 Constraints
    private func backgroundConstraints() {
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
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
