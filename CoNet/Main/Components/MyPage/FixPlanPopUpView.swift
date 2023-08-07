//
//  FixPlanPopUpView.swift
//  CoNet
//
//  Created by 이안진 on 2023/08/08.
//

import SnapKit
import Then
import UIKit

class FixPlanPopUpView: UIView {
    // 배경
    let view = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    // 제목
    let titleLabel = UILabel().then {
        $0.text = "약속 확정"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.textHigh
    }
    
    // 가로 구분선
    let horizontalDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    // 세로 짧은 구분선
    let verticalDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    // 왼쪽 버튼
    let leftButton = UIButton().then { $0.backgroundColor = .clear }
    let leftButtonTitle = UILabel().then {
        $0.text = "취소"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textMedium
    }
    
    // 오른쪽 버튼
    let rightButton = UIButton().then { $0.backgroundColor = .clear }
    let rightButtonTitle = UILabel().then {
        $0.text = "확정"
        $0.font = UIFont.body1Bold
        $0.textColor = UIColor.purpleMain
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
        addSubview(view)
    }
    
    func setTitle(_ title: String) {
//        titleLabel.text = title
    }
}
