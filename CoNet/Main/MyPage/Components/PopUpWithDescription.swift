//
//  PopUpWithDescription.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/20.
//

import SnapKit
import Then
import UIKit

class PopUpWithDescription: UIView {
    let button = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButton()
    }
    
    private func setupButton() {
        // 버튼 설정
        button.setTitle("버튼", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 버튼을 서브뷰로 추가
        addSubview(button)
        
        // 버튼의 제약 조건 설정
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    @objc private func buttonTapped() {
        // 버튼이 탭되었을 때 실행될 동작
        print("버튼이 탭되었습니다.")
    }
}
