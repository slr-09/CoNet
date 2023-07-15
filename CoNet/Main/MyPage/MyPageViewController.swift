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
    
    // 프로필 이미지 - 현재 기본 이미지로 보여줌
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    // 이름
    let nameLabel = UILabel().then {
        $0.text = "이안진"
        $0.font = UIFont.headline2Bold
        $0.textColor = UIColor.textHigh
    }
    
    let divider = UIView().then { $0.backgroundColor = UIColor.gray50 }
    let shortDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    let myPageList = MyPageList()
    let userInfoButton = UIButton().then { $0.backgroundColor = .clear }
    
    lazy var userInfoView = myPageList.arrowView(title: "회원정보", labelFont: UIFont.body1Regular!)
    lazy var notificationView = myPageList.toggleView(title: "알림 설정")
    
    lazy var noticeView = myPageList.arrowView(title: "공지사항", labelFont: UIFont.body1Regular!)
    lazy var inquireView = myPageList.arrowView(title: "문의하기", labelFont: UIFont.body1Regular!)
    lazy var termView = myPageList.noArrowView(title: "이용약관")
    
    let secondShortDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    lazy var logoutView = myPageList.noArrowView(title: "로그아웃")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        // show UI
        titleLayoutConstraints()
        layoutConstraints()
        
        userInfoView.addTarget(self, action: #selector(didClickNextButton(_:)), for: .touchUpInside)
        noticeView.addTarget(self, action: #selector(showNoticeViewController(_:)), for: .touchUpInside)
        inquireView.addTarget(self, action: #selector(showInquireViewController(_:)), for: .touchUpInside)
        termView.addTarget(self, action: #selector(didClickNextButton(_:)), for: .touchUpInside)
    }
    
    // TODO: method 통일 시키기
    @objc func didClickNextButton(_ sender: UIView) {
        let nextVC = UserInfoViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func showNoticeViewController(_ sender: UIView) {
        let nextVC = NoticeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc func showInquireViewController(_ sender: UIView) {
        let nextVC = InquireViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
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
    
    // show UI
    func layoutConstraints() {
        
        // 안전 영역
        let safeArea = view.safeAreaLayoutGuide
        
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
            verticalPadding(make: make)
        }
        
        myPageListLayoutConstraints(notificationView, previousView: userInfoView)
        
        view.addSubview(shortDivider)
        
        shortDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(safeArea.snp.width).offset(-48)
            
            make.top.equalTo(notificationView.snp.bottom).offset(24)
            verticalPadding(make: make)
        }
        
        myPageListLayoutConstraints(noticeView, previousView: shortDivider)
        myPageListLayoutConstraints(inquireView, previousView: noticeView)
        myPageListLayoutConstraints(termView, previousView: inquireView)
        
        view.addSubview(secondShortDivider)

        secondShortDivider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(safeArea.snp.width).offset(-48)

            make.top.equalTo(termView.snp.bottom).offset(24)
            verticalPadding(make: make)
        }
        
        myPageListLayoutConstraints(logoutView, previousView: secondShortDivider)
    }
    
    func myPageListLayoutConstraints(_ listView: UIView, previousView: UIView) {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(listView)

        listView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(previousView.snp.bottom).offset(24)
            verticalPadding(make: make)
        }
    }
    
    func verticalPadding(make: ConstraintMaker) {
        let safeArea = view.safeAreaLayoutGuide
        
        make.leading.equalTo(safeArea.snp.leading).offset(24)
        make.trailing.equalTo(safeArea.snp.trailing).offset(24)
    }
    
}

#if canImport(SwiftUI) && DEBUG
 import SwiftUI

 struct ViewControllerPreview: PreviewProvider {
     static var previews: some View {
         MyPageViewController().showPreview(.iPhone14Pro)
     }
 }
 #endif
