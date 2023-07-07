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
    let underlineView = UIView()
    let nameCondition1 = UILabel()
    let eMarkView1 = UIImageView()
    let nextBtn = UIButton()
    let clearButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        
        // show UI
        showScreen()
        
        // .editingChanged: editing이 될 때마다 didChangeNameTextField 함수가 호출됩니다.
        self.nameTextField.addTarget(self, action: #selector(self.didChangeNameTextField(_:)), for: .editingChanged)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // nameTextField underline 그리기
//        if underline == nil {
//            underline = CALayer()
//            underline!.frame = CGRectMake(0, nameTextField.frame.size.height-1, nameTextField.frame.width, 1)
//            underline!.backgroundColor = UIColor.gray100?.cgColor
//
//            nameTextField.layer.addSublayer(underline!)
//        }
        
        
        
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
        
        // AutoResizingMask로 인한 constraint 변환을 막기 위해 false로 설정
        xMarkView.translatesAutoresizingMaskIntoConstraints = false
        
        // constraint 설정
        xMarkView.heightAnchor.constraint(equalToConstant: 24).isActive = true  // height 설정
        xMarkView.widthAnchor.constraint(equalToConstant: 24).isActive = true   // width 설정
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
        
        enterNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        enterNameLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        enterNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        enterNameLabel.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 40).isActive = true
        
        
        // Component: 이름 입력 텍스트필드
        nameTextField.placeholder = "이름 입력"
        nameTextField.font = UIFont.body1Regular
        nameTextField.tintColor = UIColor.black
        nameTextField.clearButtonMode = .whileEditing
        
        
        if let clearButton = nameTextField.value(forKeyPath: "clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: "clearBtn"), for: .normal)
            clearButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
            clearButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        }
        
        
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        nameTextField.topAnchor.constraint(equalTo: enterNameLabel.bottomAnchor, constant: 42).isActive = true
        
        // textfield underline
        underlineView.layer.backgroundColor = UIColor.gray100?.cgColor
        
        view.addSubview(underlineView)
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        underlineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        underlineView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        underlineView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        underlineView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        
        
        // Component: 느낌표 마크 1
        eMarkView1.image = UIImage(named: "emarkPurple")
        
        view.addSubview(eMarkView1)
        
        eMarkView1.translatesAutoresizingMaskIntoConstraints = false
        
        eMarkView1.heightAnchor.constraint(equalToConstant: 12).isActive = true
        eMarkView1.widthAnchor.constraint(equalToConstant: 12).isActive = true
        eMarkView1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        eMarkView1.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 12).isActive = true
        
        // Component: 이름 입력 조건 label 1
        nameCondition1.text = "공백 없이 20자 이내의 한글, 영어, 숫자로 입력해주세요."
        nameCondition1.font = UIFont.caption
        
        view.addSubview(nameCondition1)
        
        nameCondition1.translatesAutoresizingMaskIntoConstraints = false
        
        nameCondition1.heightAnchor.constraint(equalToConstant: 16).isActive = true
        nameCondition1.leadingAnchor.constraint(equalTo: eMarkView1.trailingAnchor, constant: 5).isActive = true
        nameCondition1.topAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 10).isActive = true
        
        // Component: 느낌표 마크 2
        let eMarkView2 = UIImageView()
        eMarkView2.image = UIImage(named: "emarkPurple")
        
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
        nextBtn.setTitle("완료", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.backgroundColor = UIColor.gray200
        
        view.addSubview(nextBtn)
        
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        nextBtn.heightAnchor.constraint(equalToConstant: 52).isActive = true
        nextBtn.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 24).isActive = true
        nextBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -24).isActive = true
        nextBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -46).isActive = true
        
        nextBtn.layer.cornerRadius = 12
        
        
    }
    
    // 이름 입력 텍스트필드에 값이 입력될 경우 입력한 값이 이름 조건에 맞는지 확인합니다.
    // - Return: 조건에 맞는 경우 -> true, 조건에 맞지 않은 경우 -> false
    @objc func didChangeNameTextField(_ sender: Any?) -> Bool {
        let editText = nameTextField.text
        
        // 아무것도 입력되지 않았을 경우 return true
        if editText == "" {
            underlineView.layer.backgroundColor = UIColor.gray100?.cgColor
            nameCondition1.textColor = UIColor.black
            eMarkView1.image = UIImage(named: "emarkPurple")
            return true
        }
        
        // 공백없이 한글, 영어, 숫자로만 20자 이내
        let regexPattern = "^[0-9A-Za-zㄱ-ㅎㅏ-ㅣ가-힣]{1,20}$"
        guard let _ = editText?.range(of: regexPattern, options: .regularExpression)
        else {
            // 조건 만족하지 않을 경우 return false
            if let clearButton = nameTextField.value(forKeyPath: "clearButton") as? UIButton {
                clearButton.setImage(UIImage(named: "emarkRed"), for: .normal)
            }
            underlineView.layer.backgroundColor = UIColor.error?.cgColor
            nameCondition1.textColor = UIColor.error
            eMarkView1.image = UIImage(named: "emarkRed")
            nextBtn.layer.backgroundColor = UIColor.gray200?.cgColor
            
            return false
        }
        
        // 조건 만족한 경우 return true
        if let clearButton = nameTextField.value(forKeyPath: "clearButton") as? UIButton {
            clearButton.setImage(UIImage(named: "clearBtn"), for: .normal)
            clearButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
            clearButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        }
        underlineView.layer.backgroundColor = UIColor.purpleMain?.cgColor
        nameCondition1.textColor = UIColor.black
        eMarkView1.image = UIImage(named: "emarkPurple")
        
        nextBtn.layer.backgroundColor = UIColor.purpleMain?.cgColor
        
        return true
    }
}
