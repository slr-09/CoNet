//
//  MyPageViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/08.
//

import SnapKit
import Then
import UIKit

class MyPageViewController: UIViewController {
    // title
    let titleLabel = UILabel().then {
        $0.text = "MY"
        $0.font = UIFont.headline1
        $0.textColor = UIColor.textHigh
    }
    
    let profileImage = UIImageView().then {
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.tintColor = .gray100
    }
    
    let nameLabel = UILabel().then {
        $0.text = "이안진"
        $0.font = UIFont.headline2Bold
        $0.textColor = UIColor.textHigh
    }
    
    let divider = UIView().then {
        $0.backgroundColor = UIColor.gray100
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        // show UI
        layoutConstraints()
    }
    
    // show UI
    func layoutConstraints() {
        
        // 안전 영역
        let safeArea = view.safeAreaLayoutGuide
        
        // Component: xmark image (창 끄기)
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(safeArea.snp.top).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        
        view.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(60)
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(26)
            make.centerY.equalTo(profileImage)
            make.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
    }
}
