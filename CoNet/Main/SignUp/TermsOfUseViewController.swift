//
//  TermsOfUseViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/16.
//

import SnapKit
import Then
import UIKit

class TermsOfUseViewController: UIViewController {
    
    private var buttonSelectedStates: [Bool] = [false, false, false, false]
    
    let xButton = UIButton().then {
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }
    
    let grayLine = UIView().then {
        $0.backgroundColor = UIColor.gray200
    }
    
    let purpleLine = UIView().then {
        $0.backgroundColor = UIColor.purpleMain
    }
    
    let termsLabel = UILabel().then {
        $0.text = "커넷 서비스 이용약관을\n확인해주세요"
        $0.font = UIFont.headline1
        $0.textColor = UIColor.black
        $0.numberOfLines = 0
    }
    
    let button1 = UIButton().then {
        $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
    }
    
    let label1 = UILabel().then {
        $0.text = "모두 동의"
        $0.textColor = UIColor.black
        $0.font = UIFont.body1Medium
    }
    
    let grayLine2 = UIView().then {
        $0.backgroundColor = UIColor.gray100
    }
    
    let button2 = UIButton().then {
        $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
    }
    
    let label21 = UILabel().then {
        $0.text = "[필수] 개인정보 수집 및 이용 동의"
        $0.textColor = UIColor.black
        $0.font = UIFont.body1Medium
    }
    
    let button22 = UIButton().then {
        let button22Title = NSMutableAttributedString(string: "보기")
        button22Title.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: button22Title.length))
        
        if let purpleMain = UIColor.purpleMain {
            button22Title.addAttribute(NSAttributedString.Key.foregroundColor, value: purpleMain, range: NSRange(location: 0, length: button22Title.length))
        }

        $0.setAttributedTitle(button22Title, for: .normal)
        $0.titleLabel?.font = UIFont.body2Medium
    }
    
    let button3 = UIButton().then {
        $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
    }
    
    let label31 = UILabel().then {
        $0.text = "[필수] 이용약관 동의"
        $0.textColor = UIColor.black
        $0.font = UIFont.body1Medium
    }
    
    let button32 = UIButton().then {
        let button32Title = NSMutableAttributedString(string: "보기")
        button32Title.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: button32Title.length))
        
        if let purpleMain = UIColor.purpleMain {
            button32Title.addAttribute(NSAttributedString.Key.foregroundColor, value: purpleMain, range: NSRange(location: 0, length: button32Title.length))
        }

        $0.setAttributedTitle(button32Title, for: .normal)
        $0.titleLabel?.font = UIFont.body2Medium
    }
    
    let button4 = UIButton().then {
        $0.setImage(UIImage(named: "checkbox 2"), for: .normal)
    }
    
    let label4 = UILabel().then {
        $0.text = "[선택] 푸시 알람 수신 동의"
        $0.textColor = UIColor.black
        $0.font = UIFont.body1Medium
    }
    
    let nextButton = UIButton().then {
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
        
        self.view.addSubview(xButton)
        self.view.addSubview(grayLine)
        self.view.addSubview(purpleLine)
        applyConstraintsToTopSection()
        
        self.view.addSubview(termsLabel)
        self.view.addSubview(button1)
        self.view.addSubview(label1)
        self.view.addSubview(grayLine2)
        self.view.addSubview(button2)
        self.view.addSubview(label21)
        self.view.addSubview(button22)
        self.view.addSubview(button3)
        self.view.addSubview(label31)
        self.view.addSubview(button32)
        self.view.addSubview(button4)
        self.view.addSubview(label4)
        applyConstraintsToButtonsAndLabels()
        
        self.view.addSubview(nextButton)
        applyConstraintsToNextButton()
        
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button2Tapped), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button3Tapped), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button4Tapped), for: .touchUpInside)
        
        button1.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        button2.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        button3.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        button4.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        
        nextButton.addTarget(self, action: #selector(showEnterName(_:)), for: .touchUpInside)
    }
    
    @objc func showEnterName(_ sender: UIView) {
        let nextVC = EnterNameViewController()
        if buttonSelectedStates[1] && buttonSelectedStates[2] {
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    func applyConstraintsToTopSection() {
        let safeArea = view.safeAreaLayoutGuide
        
        xButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalTo(safeArea.snp.leading).offset(21)
            make.top.equalTo(safeArea.snp.top).offset(21)
        }
        
        grayLine.snp.makeConstraints { make in
            make.width.equalTo(394)
            make.height.equalTo(4)
            make.leading.equalTo(safeArea.snp.leading).offset(0)
            make.trailing.equalTo(safeArea.snp.trailing).offset(0)
            make.top.equalTo(xButton.snp.bottom).offset(14)
        }
        purpleLine.snp.makeConstraints { make in
            make.width.equalTo(197)
            make.height.equalTo(4)
            make.leading.equalTo(safeArea.snp.leading).offset(0)
            make.top.equalTo(grayLine.snp.top)
        }
    }
    
    func applyConstraintsToButtonsAndLabels() {
        let safeArea = view.safeAreaLayoutGuide
        
        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine.snp.bottom).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        
        button1.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.bottom).offset(338)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.width.height.equalTo(20)
        }
        
        label1.snp.makeConstraints { make in
            make.centerY.equalTo(button1)
            make.leading.equalTo(button1.snp.trailing).offset(10)
        }

        grayLine2.snp.makeConstraints { make in
            make.top.equalTo(button1.snp.bottom).offset(14)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
            make.height.equalTo(1.5)
        }
        button2.snp.makeConstraints { make in
            make.top.equalTo(grayLine2.snp.bottom).offset(19)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.width.height.equalTo(20)
        }
        label21.snp.makeConstraints { make in
            make.centerY.equalTo(button2)
            make.leading.equalTo(button2.snp.trailing).offset(10)
        }
        button22.snp.makeConstraints { make in
            make.centerY.equalTo(button2)
            make.leading.equalTo(label21.snp.trailing).offset(10)
        }
        button3.snp.makeConstraints { make in
            make.top.equalTo(button2.snp.bottom).offset(16)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.width.height.equalTo(20)
        }
        label31.snp.makeConstraints { make in
            make.centerY.equalTo(button3)
            make.leading.equalTo(button3.snp.trailing).offset(10)
        }
        button32.snp.makeConstraints { make in
            make.centerY.equalTo(button3)
            make.leading.equalTo(label31.snp.trailing).offset(10)
        }
        button4.snp.makeConstraints { make in
            make.top.equalTo(button3.snp.bottom).offset(16)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.width.height.equalTo(20)
        }
        label4.snp.makeConstraints { make in
            make.centerY.equalTo(button4)
            make.leading.equalTo(button4.snp.trailing).offset(10)
        }
    }
    
    func applyConstraintsToNextButton() {
        let safeArea = view.safeAreaLayoutGuide
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.bottom.equalTo(safeArea.snp.bottom)
            make.width.equalTo(345)
            make.height.equalTo(52)
        }
    }
    
    @objc private func buttonTouchedDown() {
        nextButton.backgroundColor = UIColor.purplePressed
    }
    
    @objc private func updateNextButtonState() {
        if (buttonSelectedStates[1] && buttonSelectedStates[2]) || buttonSelectedStates[0] {
            nextButton.backgroundColor = UIColor.purpleMain
        } else {
            nextButton.backgroundColor = UIColor.gray200
        }
    }
    
    @objc private func xButtonTapped() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
    }
    
    @objc private func button1Tapped() {
        let newState = !buttonSelectedStates[0]
        buttonSelectedStates = [newState, newState, newState, newState]
        
        let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
        button1.setImage(selectedImage, for: .normal)
        button2.setImage(selectedImage, for: .normal)
        button3.setImage(selectedImage, for: .normal)
        button4.setImage(selectedImage, for: .normal)
        
        buttonTouchedDown()
        updateNextButtonState()
    }
    
    @objc private func button2Tapped() {
        let newState = !buttonSelectedStates[1]
        buttonSelectedStates[1] = newState
            
        let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
        button2.setImage(selectedImage, for: .normal)
        
        buttonTouchedDown()
        updateNextButtonState()
    }
        
    @objc private func button3Tapped() {
        let newState = !buttonSelectedStates[2]
        buttonSelectedStates[2] = newState
            
        let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
        button3.setImage(selectedImage, for: .normal)
         
        buttonTouchedDown()
        updateNextButtonState()
    }
        
    @objc private func button4Tapped() {
        let newState = !buttonSelectedStates[3]
        buttonSelectedStates[3] = newState
        
        let selectedImage = newState ? UIImage(named: "checkbox 1") : UIImage(named: "checkbox 2")
        button4.setImage(selectedImage, for: .normal)
        
        buttonTouchedDown()
        updateNextButtonState()
    }
}
