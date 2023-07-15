//
//  UserInfoViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/09.
//

import SnapKit
import Then
import UIKit

class UserInfoViewController: UIViewController {
    let myPageList = MyPageList()
    
    // 프로필 이미지 - 현재 기본 이미지로 보여줌
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    // 이름 Label
    let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.gray300
    }
    
    // 이름 변경 버튼 row
    var name: String = "이안진"
    lazy var changeNameView = myPageList.arrowView(title: name, labelFont: UIFont.headline3Medium!)

    // 구분선
    let divider = UIView().then { $0.backgroundColor = UIColor.gray50 }

    // 연결된 계정 Label
    let linkedSocialLabel = UILabel().then {
        $0.text = "연결된 계정"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.gray300
    }
    
    // 연결된 계정 - 카카오/애플
    var social: String = "애플"
    lazy var linkedSocial = UILabel().then {
        $0.text = self.social
        $0.font = UIFont.headline3Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 연결된 계정 - 아이콘
    let linkedSocialImage = UIImageView().then {
        $0.image = UIImage(named: "linkedApple")
    }
    
    // 회원탈퇴 버튼
    let signOutButton = UIButton().then {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .kern: -0.35]
        let attributedTitle = NSAttributedString(string: "회원탈퇴", attributes: attributes)
        $0.setAttributedTitle(attributedTitle, for: .normal)
        $0.setTitleColor(UIColor.gray500, for: .normal)
        $0.titleLabel?.font = UIFont.body2Medium
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = "회원정보"
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        profileImageConstraints() // 프로필 이미지 수정 constraint
        nameViewConstraits() // 이름 변경 버튼 constraint
        linkedSocialConstraints() // 연결된 계정 constraint
        signOutConstraints() // 회원 탈퇴 constraint
        
        changeNameView.addTarget(self, action: #selector(showChangeNameViewController(_:)), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func showChangeNameViewController(_ sender: UIView) {
        let nextVC = ChangeNameViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    // 프로필 이미지 수정 버튼의 constraint
    func profileImageConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // 프로필 이미지
        view.addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.top.equalTo(safeArea.snp.top).offset(48)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
    }
    
    // 이름 변경 버튼의 constraint
    func nameViewConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        // 이름 레이블
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(profileImage.snp.bottom).offset(30)
            verticalPadding(make: make)
        }
        
        // 이름 변경 버튼 row
        view.addSubview(changeNameView)
        changeNameView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            verticalPadding(make: make)
        }
        
        // 구분선
        view.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(safeArea.snp.width).offset(-48)
            
            make.top.equalTo(changeNameView.snp.bottom).offset(16)
            verticalPadding(make: make)
        }
    }
    
    // 연결된 계정 row의 constraint
    func linkedSocialConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // 연결된 계정 레이블
        view.addSubview(linkedSocialLabel)
        linkedSocialLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.top.equalTo(divider.snp.bottom).offset(16)
            verticalPadding(make: make)
        }
        
        // 연결된 계정 - 카카오/애플
        view.addSubview(linkedSocial)
        linkedSocial.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalTo(linkedSocialLabel.snp.bottom).offset(8)
            verticalPadding(make: make)
        }
        
        // 카카오/애플 아이콘
        view.addSubview(linkedSocialImage)
        linkedSocialImage.snp.makeConstraints { make in
            make.width.equalTo(34)
            make.height.equalTo(34)
            make.centerY.equalTo(linkedSocial.snp.centerY)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
    }
    
    // 회원 탈퇴의 constraint
    func signOutConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // 회원탈퇴 버튼
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea.snp.bottom).offset(-12)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
    }
    
    // 왼쪽과 오른쪽 여백을 24로
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
        TabbarViewController().showPreview(.iPhone14Pro)
    }
}
#endif
