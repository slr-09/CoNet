//
//  GatherPopUpViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/20.
//

import SnapKit
import Then
import UIKit

class MeetingPopUpViewController: UIViewController {
    
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    let popUpView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 10
    }
    let xButton = UIButton().then {
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }
    let inviteLabel = UILabel().then {
        $0.text = "전달받은 초대코드를\n입력해주세요."
        $0.font = UIFont.headline2Bold
        $0.textColor = UIColor.black
        $0.numberOfLines = 2
    }
    let codeTextField = UITextField().then {
        $0.placeholder = "초대코드 입력"
        $0.font = UIFont.body1Medium
        $0.tintColor = UIColor.textDisabled
        $0.becomeFirstResponder()
    }
    let grayLine = UIView().then {
        $0.backgroundColor = UIColor.gray100
    }
    let infoView = UIImageView().then {
        $0.image = UIImage(named: "emarkRed")
    }
    let infoLabel = UILabel().then {
        $0.textColor = .red
        $0.font = UIFont.overline
        $0.numberOfLines = 0
    }
    let participateButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 191, height: 54)
        $0.backgroundColor = UIColor.gray200
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("참여하기", for: .normal)
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
        self.view.addSubview(codeTextField)
        self.view.addSubview(grayLine)
        self.view.addSubview(participateButton)
        self.view.addSubview(infoView)
        self.view.addSubview(infoLabel)
        applyConstraintsToComponents()
        
        codeTextField.addTarget(self, action: #selector(codeTextFieldDidChange), for: .editingChanged)
        participateButton.addTarget(self, action: #selector(participateButtonTapped), for: .touchUpInside)
        
        infoView.isHidden = true
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
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(inviteLabel.snp.bottom).offset(66)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-33)
        }
        grayLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(inviteLabel.snp.bottom).offset(96)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-33)
        }
        infoView.snp.makeConstraints { make in
            make.width.height.equalTo(8)
            make.top.equalTo(grayLine.snp.bottom).offset(6)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.centerY.equalTo(infoLabel)
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView)
            make.leading.equalTo(popUpView.snp.leading).offset(45)
        }
        participateButton.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(32)
            make.leading.equalTo(popUpView.snp.leading).offset(33)
            make.trailing.equalTo(popUpView.snp.trailing).offset(-33)
        }
    }
    
    func applyConstraintsTobackground() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
    }
    
    @objc func codeTextFieldDidChange() {
        updateGrayLineAndInfoLabel()
    }
        
    @objc func participateButtonTapped() {
        let code = codeTextField.text ?? ""
        let serverResponse = validateInviteCode(code: code)
            
        switch serverResponse {
        case .valid:
            infoView.isHidden = true
            infoLabel.isHidden = true
            participateButton.backgroundColor = UIColor.purpleMain
        case .invalidFormat:
            infoLabel.text = "올바른 초대코드를 입력해주세요."
            infoView.isHidden = false
            infoLabel.isHidden = false
            participateButton.backgroundColor = UIColor.gray200
        case .nonExistent:
            infoLabel.text = "존재하지 않는 초대코드입니다."
            infoView.isHidden = false
            infoLabel.isHidden = false
            participateButton.backgroundColor = UIColor.gray200
        case .alreadyJoined:
            infoLabel.text = "이미 참여 중인 모임의 초대코드입니다."
            infoView.isHidden = false
            infoLabel.isHidden = false
            participateButton.backgroundColor = UIColor.gray200
        }
    }
        
    func validateInviteCode(code: String) -> ServerResponse {
        if code.isEmpty {
            infoView.isHidden = true
            return .invalidFormat
        }
        
        let isValidFormat = isValidInviteCodeFormat(code: code)
        if isValidFormat {
            return .valid
        } else if code == "12345678" {
            return .alreadyJoined
        } else {
            return .nonExistent
        }
    }
        
    func updateGrayLineAndInfoLabel() {
        let code = codeTextField.text ?? ""
        let isValidFormat = isValidInviteCodeFormat(code: code)
        
        if code.isEmpty {
            grayLine.backgroundColor = UIColor.gray100
            infoView.isHidden = true
            infoLabel.isHidden = true
        } else if isValidFormat {
            grayLine.backgroundColor = UIColor.purpleMain
            infoView.isHidden = true
            infoLabel.isHidden = true
            participateButton.backgroundColor = UIColor.purpleMain
        } else {
            grayLine.backgroundColor = UIColor.error
            infoLabel.text = "올바른 초대코드를 입력해주세요."
            infoView.isHidden = false
            infoLabel.isHidden = false
            participateButton.backgroundColor = UIColor.gray200
        }
    }
        
    func isValidInviteCodeFormat(code: String) -> Bool {
        let codeRegex = "^[a-zA-Z0-9]{8}$"
        let codePredicate = NSPredicate(format: "SELF MATCHES %@", codeRegex)
        return codePredicate.evaluate(with: code)
    }
}
    
enum ServerResponse {
    case valid
    case invalidFormat
    case nonExistent
    case alreadyJoined
}
