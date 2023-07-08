//
//  UserInfoViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/09.
//

import UIKit

class UserInfoViewController: UIViewController {
    // title
    let titleLabel = UILabel().then {
        $0.text = "MY"
        $0.font = UIFont.headline1
        $0.textColor = UIColor.textHigh
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        title = "회원정보"
        titleLayoutConstraints()
    }
    
    func titleLayoutConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // Component: xmark image (창 끄기)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(safeArea.snp.top).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
    }

}
