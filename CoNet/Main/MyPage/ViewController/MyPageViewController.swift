//
//  MyPageViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/08.
//

import SnapKit
import Then
import UIKit

class NextViewController {
    var next = ""
}

class MyPageViewController: UIViewController {
    // "MY" 타이틀
    let titleLabel = UILabel().then {
        $0.text = "MY"
        $0.font = UIFont.headline1
        $0.textColor = UIColor.textHigh
    }
    
    // 프로필 이미지 - 현재 기본 이미지로 보여줌
    var profileImage = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    // 이름
    var nameLabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont.headline2Bold
        $0.textColor = UIColor.textHigh
    }
    
    // 구분선
    let divider = UIView().then { $0.backgroundColor = UIColor.gray50 }
    let shortDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    let secondShortDivider = UIView().then { $0.backgroundColor = UIColor.gray100 }
    
    // 마이페이지 리스트
    let myPageList = MyPageList()
    lazy var userInfoView = myPageList.arrowView(title: "회원정보", labelFont: UIFont.body1Regular!)
    lazy var notificationView = myPageList.toggleView(title: "알림 설정")
    lazy var noticeView = myPageList.arrowView(title: "공지사항", labelFont: UIFont.body1Regular!)
    lazy var inquireView = myPageList.arrowView(title: "문의하기", labelFont: UIFont.body1Regular!)
    lazy var termView = myPageList.noArrowView(title: "이용약관")
    lazy var logoutView = myPageList.noArrowView(title: "로그아웃")
    lazy var sideBar = myPageList.noArrowView(title: "사이드바")
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        if NextViewController().next == "waiting" {
            let nextVC = WaitingPlanListViewController()
            nextVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        // 전체 layout constraints
        layoutConstraints()
        
        userInfoView.addTarget(self, action: #selector(showUserInfoViewController), for: .touchUpInside)
        noticeView.addTarget(self, action: #selector(showNoticeViewController), for: .touchUpInside)
        inquireView.addTarget(self, action: #selector(showInquireViewController), for: .touchUpInside)
        logoutView.addTarget(self, action: #selector(showLogoutPopup), for: .touchUpInside)
        sideBar.addTarget(self, action: #selector(showSideBar), for: .touchUpInside)
        
        fetchUser()
    }
    
    private func fetchUser() {
        MyPageAPI().getUser { name, imageUrl, _, _ in
            self.nameLabel.text = name
            
//            let imageURL = URL(string: "https://www.adobe.com/kr/express/feature/image/media_142f9cf5285c2cdcda8375c1041d273a3f0383e5f.png?width=750&format=png&optimize=medium")!
            let url = URL(string: imageUrl)!
            self.loadImage(url: url)
        }
    }
    
    private func loadImage(url imageURL: URL) {
        // URLSession을 사용하여 URL에서 데이터를 비동기로 가져옵니다.
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            // 에러 처리
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            // 데이터가 정상적으로 받아와졌는지 확인
            guard let imageData = data else {
                print("No image data received")
                return
            }
            
            // 이미지 데이터를 UIImage로 변환
            if let image = UIImage(data: imageData, scale: 60) {
                // UI 업데이트는 메인 큐에서 수행
                DispatchQueue.main.async {
                    // 이미지를 UIImageView에 설정
                    self.profileImage.image = image
                }
            } else {
                print("Failed to convert image data")
            }
        }.resume()
    }
    
    @objc private func showSideBar(_ sender: UIView) {
//        let nextVC = SideBarViewController()
//        nextVC.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(nextVC, animated: true)
        
        let popupVC = SideBarViewController()
        popupVC.delegate = self
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
    
    @objc private func showUserInfoViewController(_ sender: UIView) {
        let nextVC = UserInfoViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc private func showNoticeViewController(_ sender: UIView) {
        let nextVC = NoticeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    @objc private func showInquireViewController(_ sender: UIView) {
        let nextVC = InquireViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func showLogoutPopup(_ sender: UIView) {
        let popupVC = LogoutPopUpViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
    
    // 전체 layout constraints
    private func layoutConstraints() {
        titleConstraints()
        userConstraints()
        contentsConstraints()
    }
    
    // "MY" 타이틀 constraints
    private func titleConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(safeArea.snp.top).offset(40)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
    }
    
    // 프로필 이미지, 이름 constraints
    private func userConstraints() {
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
    }
    
    // 마이페이지 리스트 contents constraints
    private func contentsConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(userInfoView)
        userInfoView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(divider.snp.bottom).offset(32)
            verticalPadding(make: make)
        }
        
        myPageListLayoutConstraints(notificationView, previousView: userInfoView)
        
        view.addSubview(shortDivider)
        shortDivider.snp.makeConstraints { make in
            dividerConstraints(make: make)
            make.top.equalTo(notificationView.snp.bottom).offset(24)
        }
        
        myPageListLayoutConstraints(noticeView, previousView: shortDivider)
        myPageListLayoutConstraints(inquireView, previousView: noticeView)
        myPageListLayoutConstraints(termView, previousView: inquireView)
        
        view.addSubview(secondShortDivider)
        secondShortDivider.snp.makeConstraints { make in
            dividerConstraints(make: make)
            make.top.equalTo(termView.snp.bottom).offset(24)
        }
        
        myPageListLayoutConstraints(logoutView, previousView: secondShortDivider)
        myPageListLayoutConstraints(sideBar, previousView: logoutView)
    }
    
    // 리스트의 공통된 constraints
    private func myPageListLayoutConstraints(_ listView: UIView, previousView: UIView) {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(previousView.snp.bottom).offset(24)
            verticalPadding(make: make)
        }
    }
    
    // 얇은 구분선 constraints
    private func dividerConstraints(make: ConstraintMaker) {
        let safeArea = view.safeAreaLayoutGuide
        
        make.height.equalTo(1)
        make.width.equalTo(safeArea.snp.width).offset(-48)
        verticalPadding(make: make)
    }
    
    // 왼쪽, 오른쪽 여백 24
    private func verticalPadding(make: ConstraintMaker) {
        let safeArea = view.safeAreaLayoutGuide
        
        make.leading.equalTo(safeArea.snp.leading).offset(24)
        make.trailing.equalTo(safeArea.snp.trailing).offset(24)
    }
    
}

extension MyPageViewController: ModalViewControllerDelegate {
    func sendDataBack(data: String) {
        print("Received data from modal: \(data)")
        
        let nextVC = WaitingPlanListViewController()
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
        // 여기서 받은 값을 이용해서 이전 ViewController에서 처리할 작업을 수행합니다.
    }
}
