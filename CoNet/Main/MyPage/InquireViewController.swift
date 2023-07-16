//
//  InquireViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/09.
//

import MessageUI
import SnapKit
import Then
import UIKit

class InquireViewController: UIViewController, MFMailComposeViewControllerDelegate {
    let titleLabel = UILabel().then {
        $0.text = "무엇을 도와드릴까요?"
        $0.font = UIFont.headline2Bold
        $0.textColor = UIColor.textHigh
    }
    
    let descriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "이용 중 불편한 점이나 문의사항을 보내주세요.\n평일 (월-금) 10:00 - 17:00, 주말/공휴일 휴무\nconet.official23@gmail.com"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textMedium
    }
    
    // 이메일 보내기 버튼
    let emailButton = UIButton().then {
        $0.backgroundColor = UIColor.grayWhite
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.purpleMain?.cgColor
    }
    
    // 이메일 아이콘
    let mailImage = UIImageView().then { $0.image = UIImage(named: "mail") }
    
    // 이메일 보내기 텍스트
    let emailLabel = UILabel().then {
        $0.text = "이메일 보내기"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 메일앱 사용 불가 안내
    let impossibleMailAppLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "기기의 메일 앱이 활성화되어있지 않습니다.\n상단의 이메일로 문의사항을 보내주시기 바랍니다."
        $0.font = UIFont.body3Medium
        $0.textColor = UIColor.textMedium
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "문의하기"
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        layoutConstraints()
        emailButtonConstraints()
        
        emailButton.addTarget(self, action: #selector(showEmail(_:)), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func showEmail(_ sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            showMailApp()
        } else {
            impossibleMailAppConstraints()
        }
    }
    
    private func showMailApp() {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["conet.official23@gmail.com"])
        mailComposer.setSubject("문의사항")
//            mailComposer.setMessageBody("Message Body", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    func layoutConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.top.equalTo(safeArea.snp.top).offset(48)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        
        view.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
    }
    
    func emailButtonConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(emailButton)
        emailButton.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(40)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        
        emailButton.addSubview(mailImage)
        mailImage.snp.makeConstraints { make in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.centerY.equalTo(emailButton.snp.centerY)
            make.leading.equalTo(emailButton.snp.leading).offset(20)
        }
        
        emailButton.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mailImage.snp.centerY)
            make.leading.equalTo(mailImage.snp.trailing).offset(6)
        }
    }
    
    func impossibleMailAppConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(impossibleMailAppLabel)
        impossibleMailAppLabel.snp.makeConstraints { make in
            make.top.equalTo(emailButton.snp.bottom).offset(12)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
    }
}

extension ViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
