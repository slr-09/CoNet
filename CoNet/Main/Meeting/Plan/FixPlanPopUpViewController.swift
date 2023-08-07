//
//  FixPlanPopUpViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/08/08.
//

import UIKit

class FixPlanPopUpViewController: UIViewController, FixPlanDelegate {
    
    // 배경 - black 투명도 30%
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    // 팝업
    let popUp = FixPlanPopUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // background color를 clear로 설정 (default: black)
        view.backgroundColor = .clear
        
        layoutConstraints()
        
        popUp.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 여기에 타임 테이블 블럭 정보 불러와서
        // 팝업 View 업데이트 하면 됩니당
        popUp.setDate("2023년 7월 3일 월요일")
        popUp.setTime("16:00")
        popUp.setMembers("이안진, 김미보, 김채린, 정아현")
    }
    
    func cancel() {
        dismissPopUp()
    }
    
    func fixPlan() {
        // 여기에 약속 확정 api 연동
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
            make.height.equalTo(340)
            make.leading.equalTo(view.snp.leading).offset(24)
            make.trailing.equalTo(view.snp.trailing).offset(24)
            
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
    }
}

protocol FixPlanDelegate: AnyObject {
    func cancel()
    func fixPlan()
}
