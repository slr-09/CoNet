//
//  UserInfoViewController.swift
//  CoNet
//
//  Created by 이안진 on 2023/07/09.
//

import SnapKit
import Then
import UIKit

class UserInfoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FunctionDelegate {
    let myPageList = MyPageList()
    
    // 프로필 이미지 - 현재 기본 이미지로 보여줌
    let profileImage = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
        $0.layer.cornerRadius = 50
        $0.clipsToBounds = true
    }
    
    // 프로필 이미지 변경 버튼
    let editProfileImageButton = UIButton().then {
        $0.setImage(UIImage(named: "editProfileImage"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    // 이름 Label
    let nameLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.gray300
    }
    
    // 이름 변경 버튼 row
    var name: String = ""
//    lazy var changeNameView = myPageList.arrowView(title: name, labelFont: UIFont.headline3Medium!)
    let changeNameButton = UIButton().then { $0.backgroundColor = .clear }
    let changeNameView = ArrowList().then { $0.setTitle("") }

    // 구분선
    let divider = UIView().then { $0.backgroundColor = UIColor.gray50 }

    // 연결된 계정 Label
    let linkedSocialLabel = UILabel().then {
        $0.text = "연결된 계정"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.gray300
    }
    
    // 연결된 계정 - 이메일
    lazy var emailLabel = UILabel().then {
        $0.text = ""
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        fetchUser()
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
        
        editProfileImageButton.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        changeNameView.delegate = self
        signOutButton.addTarget(self, action: #selector(showPopup(_:)), for: .touchUpInside)
    }
    
    func didExecuteFunction() {
        // 실행시킬 함수 내용 구현
        let nextVC = ChangeNameViewController()
        nextVC.nameTextField.text = self.name
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func fetchUser() {
        MyPageAPI().getUser { username, imageUrl, email, social in
            // 이름 설정
            self.changeNameView.setTitle(username)
            
            // 이미지 설정
            let url = URL(string: imageUrl)!
            self.loadImage(url: url)
            
            // 이메일, 소셜 계정 설정
            self.emailLabel.text = email
            self.linkedSocialImage.image = UIImage(named: social == "APPLE" ? "linkedApple" : "linkedKakao")
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
            if let image = UIImage(data: imageData, scale: 100) {
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
    
    @objc func showImagePicker(_ sender: UIView) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // 갤러리에서 이미지 선택
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 프로필 이미지 서버 전송
    // TODO: 이미지 사용 권한 물어봐야함
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 이미지 선택 완료 후에 사용할 코드 작성
            // selectedImage 변수에 선택한 이미지가 저장됨
            MyPageAPI().editProfileImage(image: selectedImage) { imageUrl in
                self.loadImage(url: URL(string: imageUrl)!)
                picker.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func showPopup(_ sender: UIView) {
        let popupVC = SignOutPopUpViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
    
    // 프로필 이미지 수정 버튼의 constraint
    func profileImageConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // 프로필 이미지
        view.addSubview(profileImage)
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.top.equalTo(safeArea.snp.top).offset(48)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
        
        view.addSubview(editProfileImageButton)
        editProfileImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.trailing.equalTo(profileImage.snp.trailing).offset(2)
            make.bottom.equalTo(profileImage.snp.bottom).offset(-8)
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
        
        view.addSubview(changeNameButton)
        changeNameButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            verticalPadding(make: make)
        }
        
        // 이름 변경 버튼 row
        changeNameButton.addSubview(changeNameView)
        changeNameView.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(safeArea.snp.width).offset(-48)
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
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
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.top.equalTo(linkedSocialLabel.snp.bottom).offset(8)
            verticalPadding(make: make)
        }
        
        // 카카오/애플 아이콘
        view.addSubview(linkedSocialImage)
        linkedSocialImage.snp.makeConstraints { make in
            make.width.equalTo(34)
            make.height.equalTo(34)
            make.centerY.equalTo(emailLabel.snp.centerY)
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
