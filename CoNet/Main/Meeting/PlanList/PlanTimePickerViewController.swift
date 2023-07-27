//
//  PlanTimePickerViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/27.
//

import SnapKit
import Then
import UIKit

class PlanTimePickerViewController: UIViewController {
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    let bottomSheet = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let grayLine = UIView().then {
        $0.layer.backgroundColor = UIColor.iconDisabled?.cgColor
        $0.layer.cornerRadius = 1.5
    }
    
    let timePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .wheels
    }
    
    let applyButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 345, height: 52)
        $0.backgroundColor = UIColor.purpleMain
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("적용하기", for: .normal)
        $0.titleLabel?.font = UIFont.body1Medium
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(background)
        self.view.addSubview(bottomSheet)
        self.view.addSubview(grayLine)
        self.view.addSubview(timePicker)
        self.view.addSubview(applyButton)
        applyConstraintsToBackground()
        applyConstraintsToComponents()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
    
    func applyConstraintsToBackground() {
        let safeArea = view.safeAreaLayoutGuide
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomSheet.snp.makeConstraints { make in
            make.height.equalTo(337)
            make.top.equalTo(safeArea.snp.top).offset(471)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func applyConstraintsToComponents() {
        let safeArea = view.safeAreaLayoutGuide
        grayLine.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(3)
            make.top.equalTo(bottomSheet.snp.top).offset(10)
            make.leading.equalTo(bottomSheet.snp.leading).offset(179)
            make.trailing.equalTo(bottomSheet.snp.trailing).offset(-178)
        }
        timePicker.snp.makeConstraints { make in
            make.width.equalTo(335)
            make.height.equalTo(164)
            make.top.equalTo(grayLine.snp.bottom).offset(36)
            make.leading.equalTo(safeArea.snp.leading).offset(29)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-29)
        }
        applyButton.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(44)
            make.top.equalTo(timePicker.snp.bottom).offset(35)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
    }
    
}
