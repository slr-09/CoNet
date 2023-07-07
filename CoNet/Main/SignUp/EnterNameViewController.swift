//
//  EnterNameViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/05.
//

import UIKit

class EnterNameViewController: UIViewController {

    // 이름 입력 textField
    let nameTextField = UITextField()
    var topBar = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        // show UI
        showScreen()
    }
    
    override func viewDidLayoutSubviews() {
        
        // nameTextField underline 그리기
        let underline = CALayer()
        underline.frame = CGRectMake(0, nameTextField.frame.size.height-1, nameTextField.frame.width, 1)
        underline.backgroundColor = UIColor.gray100?.cgColor
        
        nameTextField.layer.addSublayer(underline)
        
        
        
    }
    
    // show UI
    func showScreen() {
        
        // 안전 영역
        let safeArea = view.safeAreaLayoutGuide
        
        // Component: xmark image (창 끄기)
        let xMarkView = UIImageView()
        xMarkView.image = UIImage(systemName: "xmark")
        xMarkView.tintColor = UIColor.gray600
        
        view.addSubview(xMarkView)
        
        xMarkView.translatesAutoresizingMaskIntoConstraints = false
        
        xMarkView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        xMarkView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        xMarkView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 21).isActive = true
        xMarkView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 21).isActive = true
        
        
        // Component: top purple bar
        topBar.layer.backgroundColor = UIColor.purpleMain?.cgColor
        
        view.addSubview(topBar)
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        topBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        topBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0).isActive = true
        topBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0).isActive = true
        topBar.topAnchor.constraint(equalTo: xMarkView.bottomAnchor, constant: 14).isActive = true
        
        
        // Component: main label
        let enterNameLabel = UILabel()
        enterNameLabel.text = "이름을 입력해주세요"
        enterNameLabel.font = UIFont.headline1
        
        view.addSubview(enterNameLabel)
        
        // AutoResizingMask로 인한 constraint 변환을 막기 위해 false로 설정
        enterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        // constraint 설정
        enterNameLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        enterNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        enterNameLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 40).isActive = true
        
        
        // Component: 이름 입력 텍스트필드
        nameTextField.placeholder = "이름 입력"
        nameTextField.font = UIFont.body1Regular
        
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        nameTextField.topAnchor.constraint(equalTo: enterNameLabel.bottomAnchor, constant: 42).isActive = true
        
        // Component: 느낌표 마크 1
        let eMarkView1 = UIImageView()
        eMarkView1.image = UIImage(named: "emark")
        
        view.addSubview(eMarkView1)
        
        eMarkView1.translatesAutoresizingMaskIntoConstraints = false
        
        eMarkView1.heightAnchor.constraint(equalToConstant: 12).isActive = true
        eMarkView1.widthAnchor.constraint(equalToConstant: 12).isActive = true
        eMarkView1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        eMarkView1.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12).isActive = true
        
        // Component: 이름 입력 조건 label 1
        let nameCondition1 = UILabel()
        nameCondition1.text = "공백 없이 20자 이내의 한글, 영어, 숫자로 입력해주세요."
        nameCondition1.font = UIFont.caption
        
        view.addSubview(nameCondition1)
        
        nameCondition1.translatesAutoresizingMaskIntoConstraints = false
        
        nameCondition1.heightAnchor.constraint(equalToConstant: 16).isActive = true
        nameCondition1.leadingAnchor.constraint(equalTo: eMarkView1.trailingAnchor, constant: 5).isActive = true
        nameCondition1.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        
        // Component: 느낌표 마크 2
        let eMarkView2 = UIImageView()
        eMarkView2.image = UIImage(named: "emark")
        
        view.addSubview(eMarkView2)
        
        eMarkView2.translatesAutoresizingMaskIntoConstraints = false
        
        eMarkView2.heightAnchor.constraint(equalToConstant: 12).isActive = true
        eMarkView2.widthAnchor.constraint(equalToConstant: 12).isActive = true
        eMarkView2.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        eMarkView2.topAnchor.constraint(equalTo: eMarkView1.bottomAnchor, constant: 8).isActive = true
        
        // Component: 이름 입력 조건 label 2
        let nameCondition2 = UILabel()
        nameCondition2.text = "참여자 간 원활한 소통을 위해 실명을 권장합니다."
        nameCondition2.font = UIFont.caption
        view.addSubview(nameCondition2)
        
        nameCondition2.translatesAutoresizingMaskIntoConstraints = false
        
        nameCondition2.heightAnchor.constraint(equalToConstant: 16).isActive = true
        nameCondition2.leadingAnchor.constraint(equalTo: eMarkView2.trailingAnchor, constant: 5).isActive = true
        nameCondition2.topAnchor.constraint(equalTo: nameCondition1.bottomAnchor, constant: 4).isActive = true
        
        
        // Component: 완료 버튼
        let nextBtn = UIButton()
        nextBtn.setTitle("완료", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.backgroundColor = UIColor.gray200
        
        view.addSubview(nextBtn)
        
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true    // height 설정
        nextBtn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -46).isActive = true
        
        nextBtn.layer.cornerRadius = 12
        
        
        
    }
    

}
