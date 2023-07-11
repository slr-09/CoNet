//
//  TermsOfUseViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/09.
//

import SnapKit
import Then
import UIKit

class TermsOfUseViewController: UIViewController {
    private var button1: UIButton!
    private var button2: UIButton!
    private var button3: UIButton!
    private var button4: UIButton!
    private var customButton: UIButton!
    
    private var buttonSelectedStates: [Bool] = [false, false, false, false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        customButton.addTarget(self, action: #selector(showEnterName(_:)), for: .touchUpInside)
    }
    
    @objc func showEnterName(_ sender: UIView) {
        let nextVC = EnterNameViewController()
        if buttonSelectedStates[1] && buttonSelectedStates[2] {
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // X Button
        let xButton = UIButton().then {
            $0.setImage(UIImage(named: "closeBtn"), for: .normal)
            $0.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        }
        
        view.addSubview(xButton)
        xButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.left.equalToSuperview().offset(21)
            make.width.height.equalTo(24)
        }
        
        let grayLine = UIView().then {
            $0.backgroundColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        }
        
        view.addSubview(grayLine)
        grayLine.snp.makeConstraints { make in
            make.width.equalTo(394)
            make.height.equalTo(4)
        }
        
        let purpleLine = UIView().then {
            $0.backgroundColor = UIColor(red: 0.467, green: 0.217, blue: 1, alpha: 1)
        }
        
        view.addSubview(purpleLine)
        purpleLine.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(103)
            make.width.equalTo(197)
            make.height.equalTo(4)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(196)
            make.top.equalTo(grayLine.snp.top)
        }
        
        // Label
        let termsLabel = UILabel().then {
            $0.text = "커넷 서비스 이용약관을\n확인해주세요"
            $0.font = UIFont.headline1
            $0.textColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
            $0.numberOfLines = 0
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.16
            
            let attributedText = NSMutableAttributedString(string: "커넷 서비스 이용약관을\n확인해주세요", attributes: [
                NSAttributedString.Key.kern: -0.65,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            $0.attributedText = attributedText
        }
        
        view.addSubview(termsLabel)
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(44)
            make.width.equalTo(230)
            make.height.equalTo(72)
            make.leading.equalToSuperview().offset(24)
        }
        
        // Buttons and Labels
        // Button1
        button1 = UIButton().then {
            $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
            $0.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        }
        
        view.addSubview(button1)
        button1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(557)
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(20)
        }
        
        // label1
        let label1 = UILabel().then {
            $0.text = "모두 동의"
            $0.textColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
            $0.font = UIFont.body1Medium
            $0.numberOfLines = 0
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.16
            
            let attributedText = NSMutableAttributedString(string: "모두 동의", attributes: [
                NSAttributedString.Key.kern: -0.65,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            $0.attributedText = attributedText
        }
        
        view.addSubview(label1)
        label1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(557)
            make.left.equalToSuperview().offset(54)
            make.width.equalTo(58)
            make.height.equalTo(20)
        }
        
        // Button2
        button2 = UIButton().then {
            $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
            $0.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        }
        view.addSubview(button2)
        button2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(610)
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(20)
        }
        
        // label2-1
        let label21 = UILabel().then {
            $0.text = "[필수] 개인정보 수집 및 이용 동의"
            $0.textColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
            $0.font = UIFont.body1Medium
            $0.numberOfLines = 0
            
            let paragraphStyle = NSMutableParagraphStyle().then {
                $0.lineHeightMultiple = 1.16
            }
            
            let attributedText = NSMutableAttributedString(string: "[필수] 개인정보 수집 및 이용 동의", attributes: [
                .kern: -0.65,
                .paragraphStyle: paragraphStyle
            ])
            
            $0.attributedText = attributedText
        }
        view.addSubview(label21)
        label21.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(610)
            make.left.equalToSuperview().offset(54)
            make.width.equalTo(204)
            make.height.equalTo(20)
        }
        
        // Button2-2(보기)
        let button22 = UIButton().then {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(UIColor(red: 0.467, green: 0.217, blue: 1, alpha: 1), for: .normal)
            $0.titleLabel?.font = UIFont.body2Medium
            let attributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .kern: -0.35
            ]
            let attributedTitle = NSAttributedString(string: "보기", attributes: attributes)
            $0.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        view.addSubview(button22)
        button22.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(610)
            make.left.equalTo(label21.snp.right).offset(14)
            make.width.equalTo(24)
            make.height.equalTo(18)
        }
        
        // Button3
        button3 = UIButton().then {
            $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
            $0.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        }
        view.addSubview(button3)
        button3.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(646)
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(20)
        }
        
        // Label3-1
        let label31 = UILabel().then {
            $0.text = "[필수] 이용약관 동의"
            $0.textColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
            $0.font = UIFont.body1Medium
            $0.numberOfLines = 0
            
            let paragraphStyle = NSMutableParagraphStyle().then {
                $0.lineHeightMultiple = 1.16
            }
            
            let attributedText = NSMutableAttributedString(string: "[필수] 이용약관 동의", attributes: [
                .kern: -0.65,
                .paragraphStyle: paragraphStyle
            ])
            
            $0.attributedText = attributedText
        }
        view.addSubview(label31)
        label31.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(646)
            make.left.equalToSuperview().offset(54)
            make.width.equalTo(126)
            make.height.equalTo(20)
        }
        
        // Button3-2(보기)
        let button32 = UIButton().then {
            $0.setTitle("보기", for: .normal)
            $0.setTitleColor(UIColor(red: 0.467, green: 0.217, blue: 1, alpha: 1), for: .normal)
            $0.titleLabel?.font = UIFont.body2Medium
            let attributes: [NSAttributedString.Key: Any] = [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .kern: -0.35
            ]
            let attributedTitle = NSAttributedString(string: "보기", attributes: attributes)
            $0.setAttributedTitle(attributedTitle, for: .normal)
        }
        view.addSubview(button32)
        button32.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(646)
            make.left.equalToSuperview().offset(190)
            make.width.equalTo(24)
            make.height.equalTo(18)
        }
        
        // Button4
        button4 = UIButton().then {
            $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
            $0.addTarget(self, action: #selector(button4Tapped), for: .touchUpInside)
        }
        view.addSubview(button4)
        button4.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(682)
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(20)
        }
        
        // Label4
        let label4 = UILabel().then {
            $0.text = "[선택] 푸시 알람 수신 동의"
            $0.textColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
            $0.font = UIFont.body1Medium
            $0.numberOfLines = 0
            
            let paragraphStyle = NSMutableParagraphStyle().then {
                $0.lineHeightMultiple = 1.16
            }
            
            let attributedText = NSMutableAttributedString(string: "[선택] 푸시 알람 수신 동의", attributes: [
                .kern: -0.65,
                .paragraphStyle: paragraphStyle
            ])
            
            $0.attributedText = attributedText
        }
        view.addSubview(label4)
        label4.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(682)
            make.left.equalToSuperview().offset(54)
            make.width.equalTo(160)
            make.height.equalTo(20)
        }
        
        // Gray Line between Button1 and Button2
        let grayLine2 = UIView()
        grayLine2.backgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1)
        view.addSubview(grayLine2)
        grayLine2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(591)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(1.5)
        }
        
        // Next Button
        customButton = UIButton().then {
            $0.frame = CGRect(x: 0, y: 0, width: 345, height: 52)
            $0.backgroundColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
            $0.setTitleColor(.white, for: .normal)
            $0.setTitle("다음", for: .normal)
            $0.titleLabel?.font = UIFont.body1Medium
            $0.layer.cornerRadius = 12
            $0.layer.masksToBounds = true
        }
        
        let customButtonBackground = UIView().then {
            $0.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.16)
            $0.layer.cornerRadius = 12
            $0.layer.masksToBounds = true
        }
        
        let parentView = self.view!
        
        customButtonBackground.addSubview(customButton)
        parentView.addSubview(customButtonBackground)
        customButtonBackground.translatesAutoresizingMaskIntoConstraints = false
        
        customButtonBackground.snp.makeConstraints { make in
            make.top.equalTo(label4.snp.bottom).offset(52)
            make.centerX.equalTo(parentView.snp.centerX)
            make.width.equalTo(345)
            make.height.equalTo(52)
        }
        
        customButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    // MARK: - Button Actions
    
    // x Button click -> LoginViewController
    @objc private func xButtonTapped() {
        /*
        let loginVC = LoginViewController()
        
        // Set the presentation style to fullscreen
        loginVC.modalPresentationStyle = .fullScreen
        
        // Present the LoginViewController
        present(loginVC, animated: true, completion: nil)
        */
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func button1Tapped() {
        // 요구사항 1과 3: 버튼 1을 선택한 경우 나머지 버튼도 같은 상태로 변경
        let newState = !buttonSelectedStates[0]
        buttonSelectedStates = [newState, newState, newState, newState]
        
        // 버튼 이미지 업데이트
        let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
        button1.setImage(selectedImage, for: .normal)
        button2.setImage(selectedImage, for: .normal)
        button3.setImage(selectedImage, for: .normal)
        button4.setImage(selectedImage, for: .normal)
        
        // 요구사항 5: 버튼 2, 3의 이미지가 "checkbox 1"인 경우 customButton의 배경색 변경
        if buttonSelectedStates[1] && buttonSelectedStates[2] {
            customButton.backgroundColor = UIColor(red: 0.467, green: 0.217, blue: 1, alpha: 1)
        } else {
            customButton.backgroundColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        }
    }
    
    @objc private func button2Tapped() {
        let newState = !buttonSelectedStates[1]
            buttonSelectedStates[1] = newState
            
            let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
            button2.setImage(selectedImage, for: .normal)
        
        // 요구사항 5: 버튼 2, 3의 이미지가 "checkbox 1"인 경우 customButton의 배경색 변경
        if buttonSelectedStates[1] && buttonSelectedStates[2] {
            customButton.backgroundColor = UIColor(red: 0.467, green: 0.217, blue: 1, alpha: 1)
        } else {
            customButton.backgroundColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        }
    }
    
    @objc private func button3Tapped() {
        let newState = !buttonSelectedStates[2]
            buttonSelectedStates[2] = newState
            
            let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
            button3.setImage(selectedImage, for: .normal)
        
        // 요구사항 5: 버튼 2, 3의 이미지가 "checkbox 1"인 경우 customButton의 배경색 변경
        if buttonSelectedStates[1] && buttonSelectedStates[2] {
            customButton.backgroundColor = UIColor(red: 0.467, green: 0.217, blue: 1, alpha: 1)
        } else {
            customButton.backgroundColor = UIColor(red: 0.757, green: 0.757, blue: 0.757, alpha: 1)
        }
    }
    
    @objc private func button4Tapped() {
        let newState = !buttonSelectedStates[3]
            buttonSelectedStates[3] = newState
            
            let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
            button4.setImage(selectedImage, for: .normal)
    }
}
