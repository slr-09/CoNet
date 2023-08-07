//
//  HistoryAddViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/23.
//

import SnapKit
import Then
import UIKit

class HistoryAddViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var planId: Int = 0
    
    var isPhotoUploaded = false
    var isContentsEntered = false
    
    let scrollview = UIScrollView().then { $0.backgroundColor = .clear }
    let contentView = UIView().then { $0.backgroundColor = .clear }
    
    let completionButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = UIFont.headline3Medium
        $0.setTitleColor(.textDisabled, for: .normal)
        $0.titleLabel?.lineBreakMode = .byClipping
    }
    
    let planNameLabel = UILabel().then {
        $0.text = "약속 이름"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planNameText = UILabel().then {
        $0.text = "모임모임"
        $0.font = UIFont.headline3Regular
        $0.textColor = UIColor.textDisabled
    }
    
    let grayLine1 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    
    let planDateLabel = UILabel().then {
        $0.text = "약속 날짜"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planDateText = UILabel().then {
        $0.text = "2023.07.15"
        $0.font = UIFont.headline3Regular
        $0.textColor = UIColor.textDisabled
    }
    
    let grayLine2 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    
    let planTimeLabel = UILabel().then {
        $0.text = "약속 시간"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planTimeText = UILabel().then {
        $0.text = "10:00"
        $0.font = UIFont.headline3Regular
        $0.textColor = UIColor.textDisabled
    }

    let grayLine3 = UIView().then {
        $0.backgroundColor = UIColor.iconDisabled
    }
    
    let memberLabel = UILabel().then {
        $0.text = "참여자"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let member1ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member1NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textDisabled
    }
    
    let member2ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member2NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textDisabled
    }

    let member3ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member3NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textDisabled
    }
    
    let grayLine4 = UIView().then {
        $0.backgroundColor = UIColor.gray50
    }
    
    let historyLabel = UILabel().then {
        $0.text = "히스토리"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.black
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let photoLabel = UILabel().then {
        $0.text = "사진"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white
        $0.layer.borderColor = UIColor.gray200?.cgColor
        $0.layer.borderWidth = 1
    }
    
    let photoAddButton = UIButton().then {
        $0.setImage(UIImage(named: "imageplus"), for: .normal)
    }
    
    let photoAddLabel = UILabel().then {
        $0.text = "사진 추가"
        $0.font = UIFont.overline
        $0.textColor = UIColor.iconDisabled
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let contentsLabel = UILabel().then {
        $0.text = "내용"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let contentsView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.borderColor = UIColor.gray200?.cgColor
        $0.layer.borderWidth = 1
    }
    
    let contentsTextField = UITextField().then {
        $0.placeholder = "내용을 입력하세요."
        $0.font = UIFont.body2Medium
        $0.tintColor = UIColor.black
        $0.becomeFirstResponder()
        $0.contentVerticalAlignment = .top
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // navigation bar title "iOS 스터디"로 지정
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "히스토리 등록하기"
        
        // 네비게이션 바 item 추가 - 뒤로가기, 사이드바 버튼
        addNavigationBarItem()
        
        layoutConstraints()
        
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
        photoAddButton.addTarget(self, action: #selector(photoAddButtonTapped), for: .touchUpInside)
        
        updatePhotoImageViewSize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
        PlanAPI().getPlanDetail(planId: planId) { plans in
            self.planNameText.text = plans.planName
            self.planDateText.text = plans.date
            self.planTimeText.text = plans.time
            self.member1NameLabel.text = plans.members[0].name
        }
    }
    
    private func addNavigationBarItem() {
        // 사이드바 버튼 추가
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: completionButton)
        navigationItem.rightBarButtonItem = barButtonItem
    }
}

extension HistoryAddViewController {
    private func layoutConstraints() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        applyConstraintsToscrollview()
        
        contentView.addSubview(planNameLabel)
        contentView.addSubview(planNameText)
        contentView.addSubview(grayLine1)
        applyConstraintsToPlanName()
        
        contentView.addSubview(planDateLabel)
        contentView.addSubview(planDateText)
        contentView.addSubview(grayLine2)
        applyConstraintsToPlanDate()
        
        contentView.addSubview(planTimeLabel)
        contentView.addSubview(planTimeText)
        contentView.addSubview(grayLine3)
        applyConstraintsToPlanTime()
        
        contentView.addSubview(memberLabel)
        contentView.addSubview(member1ImageView)
        contentView.addSubview(member1NameLabel)
        contentView.addSubview(member2ImageView)
        contentView.addSubview(member2NameLabel)
        contentView.addSubview(member3ImageView)
        contentView.addSubview(member3NameLabel)
        applyConstraintsToMember()
        
        contentView.addSubview(grayLine4)
        contentView.addSubview(historyLabel)
        applyConstraintsToHistory()
        
        contentView.addSubview(photoLabel)
        contentView.addSubview(photoImageView)
        contentView.addSubview(photoAddButton)
        contentView.addSubview(photoAddLabel)
        applyConstraintsToPhoto()
        
        contentsTextField.delegate = self
        contentView.addSubview(contentsLabel)
        contentView.addSubview(contentsView)
        contentView.addSubview(contentsTextField)
        applyConstraintsToContents()
    }
    
    private func applyConstraintsToscrollview() {
        scrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(0)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollview.contentLayoutGuide)
            make.width.equalTo(scrollview.frameLayoutGuide)
            make.height.equalTo(2000)
        }
    }

    func applyConstraintsToPlanName() {
        // 안전 영역
        let safeArea = view.safeAreaLayoutGuide
        
        planNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        planNameText.snp.makeConstraints { make in
            make.top.equalTo(planNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        grayLine1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planNameText.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
    }

    func applyConstraintsToPlanDate() {
        planDateLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine1.snp.bottom).offset(26)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        planDateText.snp.makeConstraints { make in
            make.top.equalTo(planDateLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        grayLine2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planDateText.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
    }

    func applyConstraintsToPlanTime() {
        planTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine2.snp.bottom).offset(26)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        planTimeText.snp.makeConstraints { make in
            make.top.equalTo(planTimeLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        grayLine3.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(planTimeText.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
    }

    func applyConstraintsToMember() {
        memberLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine3.snp.bottom).offset(26)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        member1ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(memberLabel.snp.bottom).offset(14)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        member1NameLabel.snp.makeConstraints { make in
            make.width.equalTo(93)
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member1ImageView.snp.trailing).offset(10)
        }
        member2ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member1ImageView.snp.trailing).offset(138)
        }
        member2NameLabel.snp.makeConstraints { make in
            make.width.equalTo(93)
            make.centerY.equalTo(member2ImageView)
            make.leading.equalTo(member2ImageView.snp.trailing).offset(10)
        }
        member3ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(member1ImageView.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        member3NameLabel.snp.makeConstraints { make in
            make.width.equalTo(93)
            make.centerY.equalTo(member3ImageView)
            make.leading.equalTo(member3ImageView.snp.trailing).offset(10)
        }
    }

    func applyConstraintsToHistory() {
        grayLine4.snp.makeConstraints { make in
            make.width.equalTo(393)
            make.height.equalTo(12)
            make.top.equalTo(member3ImageView.snp.bottom).offset(32)
        }
        historyLabel.snp.makeConstraints { make in
            make.width.equalTo(62)
            make.top.equalTo(grayLine4.snp.bottom).offset(24)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
    }
    
    func applyConstraintsToPhoto() {
        photoLabel.snp.makeConstraints { make in
            make.top.equalTo(historyLabel.snp.bottom).offset(26)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(88)
            make.top.equalTo(photoLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        photoAddButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(photoImageView.snp.top).offset(24)
            make.leading.equalTo(photoImageView.snp.leading).offset(32)
            make.trailing.equalTo(photoImageView.snp.trailing).offset(-32)
        }
        photoAddLabel.snp.makeConstraints { make in
            make.width.equalTo(37)
            make.top.equalTo(photoAddButton.snp.bottom).offset(4)
            make.leading.equalTo(photoImageView.snp.leading).offset(25)
            make.trailing.equalTo(photoImageView.snp.trailing).offset(-26)
        }
    }

    func applyConstraintsToContents() {
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(26)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        contentsView.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(163)
            make.top.equalTo(contentsLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        contentsTextField.snp.makeConstraints { make in
            make.top.equalTo(contentsView.snp.top).offset(25)
            make.leading.equalTo(contentsView.snp.leading).offset(25)
            make.trailing.equalTo(contentsView.snp.trailing).offset(-25)
        }
    }
}

// MARK: - Button Actions Extensions
extension HistoryAddViewController {
    @objc private func completionButtonTapped() {
        print("wow wow")
        guard let image = photoImageView.image else { return }
        guard let description = contentsTextField.text else { return }
        HistoryAPI().postHistory(planId: planId, image: image, description: description) { isSuccess in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func photoAddButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isContentsEntered = !textField.text!.isEmpty
        updateCompletionButtonColor()
    }
    
    func updateCompletionButtonColor() {
        if isContentsEntered || isPhotoUploaded {
            completionButton.setTitleColor(.purpleMain, for: .normal)
        } else {
            completionButton.setTitleColor(.textDisabled, for: .normal)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            photoImageView.image = pickedImage
            isPhotoUploaded = true
            updatePhotoImageViewSize()
            updateCompletionButtonColor()
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func updatePhotoImageViewSize() {
        photoImageView.clipsToBounds = true
        
        photoImageView.snp.remakeConstraints { make in
            if isPhotoUploaded {
                make.width.height.equalTo(345)
                make.top.equalTo(photoLabel.snp.bottom).offset(8)
                make.leading.equalTo(contentView.snp.leading).offset(24)
            } else {
                make.width.height.equalTo(88)
                make.top.equalTo(photoLabel.snp.bottom).offset(8)
                make.leading.equalTo(contentView.snp.leading).offset(24)
            }
        }
        photoAddButton.snp.makeConstraints { make in
            if isPhotoUploaded {
                make.width.height.equalTo(24)
                make.centerX.equalTo(photoImageView)
                make.centerY.equalTo(photoImageView)
            } else {
                make.width.height.equalTo(24)
                make.top.equalTo(photoImageView.snp.top).offset(24)
                make.leading.equalTo(photoImageView.snp.leading).offset(32)
                make.trailing.equalTo(photoImageView.snp.trailing).offset(-32)
            }
        }
        photoAddLabel.snp.makeConstraints { make in
            if isPhotoUploaded {
                make.width.equalTo(37)
                make.top.equalTo(photoAddButton.snp.bottom).offset(4)
                make.leading.equalTo(photoImageView.snp.leading).offset(25)
                make.trailing.equalTo(photoImageView.snp.trailing).offset(-26)
            } else {
                
            }
        }
    }
}
