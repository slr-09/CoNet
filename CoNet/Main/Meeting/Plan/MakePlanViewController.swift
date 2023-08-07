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
    var meetingId: Int = 0
    
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
        $0.setTitle("만들기", for: .normal)
        $0.titleLabel?.font = UIFont.body1Medium
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    var date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "약속 만들기"
        
        layoutConstraints()
        
        xnameButton.addTarget(self, action: #selector(xnameButtonTapped), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(calendarButtonTapped), for: .touchUpInside)
        makeButton.addTarget(self, action: #selector(makeButtonTapped), for: .touchUpInside)
        
        planNameTextField.delegate = self
        planStartDateField.delegate = self
        planNameTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        planStartDateField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        // calendarViewController에서 데이터 받기
        NotificationCenter.default.addObserver(self, selector: #selector(dataReceivedByCalendarVC(notification:)), name: NSNotification.Name("ToMakePlanVC"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func dataReceivedByCalendarVC(notification: Notification) {
        if var data = notification.userInfo?["date"] as? String {
            date = data
            data = data.replacingOccurrences(of: "-", with: ".")
            planStartDateField.text = data
        }
        updateMakeButtonState()
    }
    
    @objc private func textFieldEditingChanged(_ textField: UITextField) {
        if textField == planNameTextField {
            if let text = textField.text {
                let maxLength = 20
                var newText = text
                if text.count > maxLength {
                    let index = text.index(text.startIndex, offsetBy: maxLength)
                    newText = String(text[..<index])
                }
                textCountLabel.text = "\(newText.count)/20"
                xnameButton.isHidden = newText.isEmpty
                textField.text = newText
            }
        }
        updateMakeButtonState()
    }
    
    @objc private func xnameButtonTapped() {
        planNameTextField.text = ""
        planNameTextField.sendActions(for: .editingChanged)
    }
    
    @objc private func calendarButtonTapped() {
        let bottomSheetVC = PlanDateButtonSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overCurrentContext
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        self.present(bottomSheetVC, animated: false, completion: nil)
    }
    
    // 이전 ViewController로 데이터를 전달하는 delegate
    weak var delegate: MeetingMainViewControllerDelegate?
    
    @objc private func makeButtonTapped() {
        if makeButton.backgroundColor == UIColor.purpleMain {
            guard let newName = planNameTextField.text else { return }
            guard let newStartDate = planStartDateField.text else { return }
            let date = newStartDate.replacingOccurrences(of: ".", with: "-")
            PlanAPI().createPlan(teamId: meetingId, planName: newName, planStartPeriod: date) { planId, isSuccess in
                if isSuccess {
                    self.navigationController?.popViewController(animated: true)
                    self.delegate?.sendIntDataBack(data: planId)
                }
            }
        }
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

// layout
extension MakePlanViewController {
    func layoutConstraints() {
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
    }
    
    func applyConstraintsToPlanName() {
        let safeArea = view.safeAreaLayoutGuide
        planNameLabel.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(20)
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
            make.height.equalTo(16)
            make.top.equalTo(grayLine2.snp.bottom).offset(6)
            make.leading.equalTo(safeArea.snp.leading).offset(41)
        }
    }
    
    func applyConstraintsToMakeButton() {
        let safeArea = view.safeAreaLayoutGuide
        makeButton.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(52)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.bottom.equalTo(safeArea.snp.bottom).offset(-12)
        }
    }
}
