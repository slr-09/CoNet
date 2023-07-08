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
    
    let divider = UIView().then { $0.backgroundColor = UIColor.gray50 }
    let shortDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    let secondShortDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    var myPageList = MyPageList()
    
    lazy var userInfoView = myPageList.arrowView(title: "회원정보")
    lazy var notificationView = myPageList.toggleView(title: "알림 설정")
    
    lazy var noticeView = myPageList.arrowView(title: "공지사항")
    lazy var inquireView = myPageList.arrowView(title: "문의하기")
    lazy var termView = myPageList.noArrowView(title: "이용약관")
    
    lazy var logoutView = myPageList.noArrowView(title: "로그아웃")
    
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
        
        view.addSubview(divider)
        
        divider.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.width.equalTo(safeArea.snp.width)
            make.top.equalTo(profileImage.snp.bottom).offset(22)
        }
        
        view.addSubview(userInfoView)
        
        userInfoView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(divider.snp.bottom).offset(32)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(notificationView)
        
        notificationView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(userInfoView.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(shortDivider)
        
        shortDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(safeArea.snp.width).offset(-48)
            
            make.top.equalTo(notificationView.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(noticeView)

        noticeView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(shortDivider.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(inquireView)

        inquireView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(noticeView.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(termView)

        termView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(inquireView.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(secondShortDivider)

        secondShortDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(safeArea.snp.width).offset(-48)

            make.top.equalTo(termView.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
        
        view.addSubview(logoutView)

        logoutView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(secondShortDivider.snp.bottom).offset(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(24)
        }
    }
}
