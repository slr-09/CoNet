//
//  PlanInfoEditViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/25.
//

import SnapKit
import Then
import UIKit

class PlanInfoEditViewController: UIViewController, UITextFieldDelegate {
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "prevBtn"), for: .normal)
    }
    
    let planInfoLabel = UILabel().then {
        $0.text = "상세 페이지"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.black
        $0.numberOfLines = 0
    }
    
    let completionButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.headline3Medium
        $0.setTitleColor(UIColor.purpleMain, for: .normal)
    }
    
    let planNameLabel = UILabel().then {
        $0.text = "약속 이름"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planNameTextField = UITextField().then {
        $0.placeholder = "모임모임"
        $0.font = UIFont.headline3Regular
        $0.tintColor = UIColor.black
        $0.becomeFirstResponder()
    }
    
    let xnameButton = UIButton().then {
        $0.setImage(UIImage(named: "clearBtn"), for: .normal)
    }
    
    let textCountLabel = UILabel().then {
        $0.font = UIFont.caption
        $0.textColor = UIColor.textDisabled
    }
    
    let grayLine1 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    
    let planDateLabel = UILabel().then {
        $0.text = "약속 날짜"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planDateTextField = UITextField().then {
        $0.placeholder = "2023.07.15"
        $0.font = UIFont.headline3Regular
        $0.tintColor = UIColor.black
        $0.becomeFirstResponder()
    }
    
    let calendarButton = UIButton().then {
        $0.setImage(UIImage(named: "calendar"), for: .normal)
    }
    
    let grayLine2 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    
    let planTimeLabel = UILabel().then {
        $0.text = "약속 시간"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planTimeTextField = UITextField().then {
        $0.placeholder = "10:00"
        $0.font = UIFont.headline3Regular
        $0.tintColor = UIColor.black
        $0.becomeFirstResponder()
    }
    
    let clockButton = UIButton().then {
        $0.setImage(UIImage(named: "clock"), for: .normal)
    }
    
    let grayLine3 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    
    let memberLabel = UILabel().then {
        $0.text = "참여자"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let member1ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member1NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }
    
    let member1DelButton = UIButton().then {
        $0.setImage(UIImage(named: "delete"), for: .normal)
    }
    
    let member2ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member2NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }
    
    let member2DelButton = UIButton().then {
        $0.setImage(UIImage(named: "delete"), for: .normal)
    }
    
    let member3ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member3NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }
    
    let member3DelButton = UIButton().then {
        $0.setImage(UIImage(named: "delete"), for: .normal)
    }
    
    let memberAddButton = UIButton().then {
        $0.setImage(UIImage(named: "addPeople"), for: .normal)
    }
    
    let memberAddLabel = UILabel().then {
        $0.text = "추가하기"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textDisabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(backButton)
        self.view.addSubview(planInfoLabel)
        self.view.addSubview(completionButton)
        applyConstraintsToTopSection()
        
        self.view.addSubview(planNameLabel)
        self.view.addSubview(planNameTextField)
        self.view.addSubview(xnameButton)
        self.view.addSubview(textCountLabel)
        self.view.addSubview(grayLine1)
        applyConstraintsToPlanName()
        
        self.view.addSubview(planDateLabel)
        self.view.addSubview(planDateTextField)
        self.view.addSubview(calendarButton)
        self.view.addSubview(grayLine2)
        applyConstraintsToPlanDate()

        self.view.addSubview(planTimeLabel)
        self.view.addSubview(planTimeTextField)
        self.view.addSubview(clockButton)
        self.view.addSubview(grayLine3)
        applyConstraintsToPlanTime()
        
        self.view.addSubview(memberLabel)
        self.view.addSubview(member1ImageView)
        self.view.addSubview(member1NameLabel)
        self.view.addSubview(member1DelButton)
        self.view.addSubview(member2ImageView)
        self.view.addSubview(member2NameLabel)
        self.view.addSubview(member2DelButton)
        self.view.addSubview(member3ImageView)
        self.view.addSubview(member3NameLabel)
        self.view.addSubview(member3DelButton)
        self.view.addSubview(memberAddButton)
        self.view.addSubview(memberAddLabel)
        applyConstraintsToPlanMember()
        
        xnameButton.addTarget(self, action: #selector(xnameButtonTapped), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(didTapcalendarButton), for: .touchUpInside)
        clockButton.addTarget(self, action: #selector(didTapclockButton), for: .touchUpInside)
        memberAddButton.addTarget(self, action: #selector(didTapmemberAddButton), for: .touchUpInside)
        
        planNameTextField.delegate = self
        planDateTextField.delegate = self
        planTimeTextField.delegate = self
        planNameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        planDateTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        planTimeTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    func applyConstraintsToTopSection() {
        let safeArea = view.safeAreaLayoutGuide
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(safeArea.snp.top).offset(41)
            make.leading.equalTo(safeArea.snp.leading).offset(17)
        }
        planInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(41)
            make.leading.equalTo(backButton.snp.trailing).offset(116)
        }
        completionButton.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(41)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
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
        planDateLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine1.snp.bottom).offset(26)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        planDateTextField.snp.makeConstraints { make in
            make.top.equalTo(planDateLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        calendarButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.equalTo(planDateLabel.snp.bottom).offset(12)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        grayLine2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planDateLabel.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
    }
    
    func applyConstraintsToPlanTime() {
        let safeArea = view.safeAreaLayoutGuide
        planTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine2.snp.bottom).offset(26)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        planTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(planTimeLabel.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        clockButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.top.equalTo(planTimeLabel.snp.bottom).offset(12)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        grayLine3.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planTimeLabel.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
    }
    
    func applyConstraintsToPlanMember() {
        let safeArea = view.safeAreaLayoutGuide
        memberLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine3.snp.bottom).offset(26)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        member1ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(memberLabel.snp.bottom).offset(14)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        member1NameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member1ImageView.snp.trailing).offset(10)
        }
        member1DelButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member1ImageView.snp.trailing).offset(107)
        }
        member2ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(memberLabel.snp.bottom).offset(14)
            make.leading.equalTo(safeArea.snp.leading).offset(204)
        }
        member2NameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member2ImageView.snp.trailing).offset(10)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
        member2DelButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(member2ImageView)
            make.leading.equalTo(member2ImageView.snp.trailing).offset(107)
        }
        member3ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(member1ImageView.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        member3NameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(member3ImageView)
            make.leading.equalTo(safeArea.snp.leading).offset(76)
        }
        member3DelButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(member3ImageView)
            make.leading.equalTo(member3ImageView.snp.trailing).offset(107)
        }
        memberAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(member3ImageView.snp.top)
            make.leading.equalTo(member3DelButton.snp.trailing).offset(15)
        }
        memberAddLabel.snp.makeConstraints { make in
            make.centerY.equalTo(memberAddButton)
            make.leading.equalTo(member3DelButton.snp.trailing).offset(67)
        }
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField == planNameTextField {
            guard let text = textField.text else { return }
            let nameCount = text.count

            textCountLabel.text = "\(nameCount)/20"
            xnameButton.isHidden = text.isEmpty
        }
    }
    
    @objc private func xnameButtonTapped() {
        planNameTextField.text = ""
        planNameTextField.sendActions(for: .editingChanged)
    }
    
    @objc func didTapmemberAddButton(_ sender: Any) {
        let addVC = PlanMemberBottomSheetViewController()
        addVC.modalPresentationStyle = .overFullScreen
        present(addVC, animated: false, completion: nil)
    }
    
    @objc func didTapcalendarButton(_ sender: Any) {
        let addVC = PlanDateButtonSheetViewController()
        addVC.modalPresentationStyle = .overFullScreen
        present(addVC, animated: false, completion: nil)
    }
    
    @objc func didTapclockButton(_ sender: Any) {
        let addVC = PlanTimePickerViewController()
        addVC.modalPresentationStyle = .overFullScreen
        present(addVC, animated: false, completion: nil)
    }
}
extension PlanInfoEditViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == planNameTextField {
            grayLine1.backgroundColor = UIColor.purpleMain
        } else if textField == planDateTextField {
            grayLine2.backgroundColor = UIColor.purpleMain
        } else if textField == planTimeTextField {
            grayLine3.backgroundColor = UIColor.purpleMain
        }
        xnameButton.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == planNameTextField {
            grayLine1.backgroundColor = UIColor.iconDisabled
        } else if textField == planDateTextField {
            grayLine2.backgroundColor = UIColor.iconDisabled
        } else if textField == planTimeTextField {
            grayLine3.backgroundColor = UIColor.iconDisabled
        }
        xnameButton.isHidden = true
    }
}
