//
//  InquireViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/09.
//

import UIKit

class InquireViewController: UIViewController {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "문의하기"
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        layoutConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
}
