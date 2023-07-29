//
//  MakePlanViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/25.
//

import SnapKit
import Then
import UIKit

class MakePlanViewController: UIViewController, UITextFieldDelegate {
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "prevBtn"), for: .normal)
    }
    let makePlanLabel = UILabel().then {
        $0.text = "약속 만들기"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.black
    }
    let planNameLabel = UILabel().then {
        $0.text = "약속 이름"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.gray300
    }
    let planNameTextField = UITextField().then {
        $0.placeholder = "약속 이름 입력"
        $0.font = UIFont.headline3Regular
        $0.tintColor = UIColor.textDisabled
        $0.becomeFirstResponder()
    }
    let xnameButton = UIButton().then {
        $0.setImage(UIImage(named: "clearBtn"), for: .normal)
        $0.isHidden = true
    }
    let textCountLabel = UILabel().then {
        $0.font = UIFont.caption
        $0.textColor = UIColor.textDisabled
    }
    let grayLine1 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    let planStartDateLabel = UILabel().then {
        $0.text = "약속 기간 - 시작일"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.gray300
    }
    let planStartDateField = UITextField().then {
        $0.placeholder = "YYYY.MM.DD"
        $0.font = UIFont.headline3Regular
        $0.tintColor = UIColor.textDisabled
        $0.becomeFirstResponder()
    }
    let calendarButton = UIButton().then {
        $0.setImage(UIImage(named: "calendar"), for: .normal)
    }
    let grayLine2 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    let planStartDateUnderImage = UIImageView().then {
        $0.image = UIImage(named: "emarkPurple")
    }
    let planStartDateUnderLabel = UILabel().then {
        $0.text = "약속 기간은 시작일로부터 7일 자동 설정됩니다"
        $0.font = UIFont.caption
        $0.textColor = UIColor.textHigh
    }
    let makeButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 345, height: 52)
        $0.backgroundColor = UIColor.gray200
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = UIFont.body1Medium
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(backButton)
        self.view.addSubview(makePlanLabel)
        applyConstraintsToTopSection()
        
        self.view.addSubview(planNameLabel)
        self.view.addSubview(xnameButton)
        self.view.addSubview(planNameTextField)
        self.view.addSubview(textCountLabel)
        self.view.addSubview(grayLine1)
        applyConstraintsToPlanName()
        
        self.view.addSubview(planStartDateLabel)
        self.view.addSubview(planStartDateField)
        self.view.addSubview(calendarButton)
        self.view.addSubview(grayLine2)
        self.view.addSubview(planStartDateUnderImage)
        self.view.addSubview(planStartDateUnderLabel)
        applyConstraintsToPlanDate()
        
        self.view.addSubview(makeButton)
        applyConstraintsToMakeButton()
        
        xnameButton.addTarget(self, action: #selector(xnameButtonTapped), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        
        planNameTextField.delegate = self
        planStartDateField.delegate = self
        planNameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        planStartDateField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    func applyConstraintsToTopSection() {
        let safeArea = view.safeAreaLayoutGuide
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(safeArea.snp.top).offset(41)
            make.leading.equalTo(safeArea.snp.leading).offset(17)
        }
        makePlanLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(41)
            make.leading.equalTo(backButton.snp.trailing).offset(116)
        }
    }
    
    func applyConstraintsToPlanName() {
        let safeArea = view.safeAreaLayoutGuide
        planNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(44)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        planNameTextField.snp.makeConstraints { make in
            make.top.equalTo(planNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        xnameButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.equalTo(planNameLabel.snp.bottom).offset(12)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        grayLine1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planNameLabel.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        textCountLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalTo(grayLine1.snp.bottom).offset(4)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
    }
    
    func applyConstraintsToPlanDate() {
        let safeArea = view.safeAreaLayoutGuide
        planStartDateLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine1.snp.bottom).offset(38)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        planStartDateField.snp.makeConstraints { make in
            make.top.equalTo(planStartDateLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        calendarButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.equalTo(planStartDateLabel.snp.bottom).offset(12)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        grayLine2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planStartDateLabel.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        planStartDateUnderImage.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.top.equalTo(grayLine2.snp.bottom).offset(8)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        planStartDateUnderLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine2.snp.bottom).offset(6)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
    }
    
    func applyConstraintsToMakeButton() {
        let safeArea = view.safeAreaLayoutGuide
        makeButton.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(52)
            make.top.equalTo(planStartDateUnderLabel.snp.bottom).offset(435)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-46)
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField == planNameTextField {
            guard let text = textField.text else { return }
            let nameCount = text.count

            textCountLabel.text = "\(nameCount)/20"
            xnameButton.isHidden = text.isEmpty
        }
        updateMakeButtonState()
    }
    
    @objc private func xnameButtonTapped() {
        planNameTextField.text = ""
        planNameTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func calendarButtonTapped() {
        let bottomSheetVC = PlanDateButtonSheetViewController()
            bottomSheetVC.modalPresentationStyle = .overFullScreen
            self.present(bottomSheetVC, animated: false, completion: nil)
    }
    
    private func updateMakeButtonState() {
        let isPlanNameFilled = !(planNameTextField.text?.isEmpty ?? true)
        let isPlanStartDateFilled = !(planStartDateField.text?.isEmpty ?? true)
        
        if isPlanNameFilled && isPlanStartDateFilled {
            makeButton.backgroundColor = UIColor.purpleMain
        } else {
            makeButton.backgroundColor = UIColor.gray200
        }
    }
}
extension MakePlanViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == planNameTextField {
            grayLine1.backgroundColor = UIColor.purpleMain
            xnameButton.isHidden = false
        } else if textField == planStartDateField {
            grayLine2.backgroundColor = UIColor.purpleMain
            xnameButton.isHidden = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == planNameTextField {
            grayLine1.backgroundColor = UIColor.iconDisabled
        } else if textField == planStartDateField {
            grayLine2.backgroundColor = UIColor.iconDisabled
        }
        xnameButton.isHidden = true
    }
}
