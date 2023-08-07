//
//  PlanInfoViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/24.
//

import SnapKit
import Then
import UIKit

class PlanInfoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var planId: Int = 17
    private var plansCount: Int = 0
    private var planDetail: [PlanDetail] = []
    
    var dataStatus: [dataStatus] = []
    
    struct dataStatus {
        var isPhotoUploaded = false
        var isTextUploaded = false
        var ishistoryExisted = false
    }
    
    let scrollview = UIScrollView().then { $0.backgroundColor = .clear }
    let contentView = UIView().then { $0.backgroundColor = .clear }
    
    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "prevBtn"), for: .normal)
    }
    let planInfoLabel = UILabel().then {
        $0.text = "상세 페이지"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.black
        $0.adjustsFontSizeToFitWidth = true
    }
    let sideBarButton = UIButton().then {
        $0.setImage(UIImage(named: "sidebar"), for: .normal)
    }
    let planNameLabel = UILabel().then {
        $0.text = "약속 이름"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textDisabled
    }
    
    let planNameText = UILabel().then {
        $0.text = "모임모임"
        $0.font = UIFont.headline3Regular
        $0.textColor = UIColor.black
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
        $0.textColor = UIColor.black
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
        $0.textColor = UIColor.black
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
    }
    
    let member2ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member2NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }

    let member3ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member3NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
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
    
    let noPhotoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white
        $0.layer.borderColor = UIColor.gray200?.cgColor
        $0.layer.borderWidth = 1
    }
    
    let photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.white
        $0.layer.borderColor = UIColor.gray200?.cgColor
        $0.layer.borderWidth = 1
    }
    
    let noPhotoView = UIImageView().then {
        $0.image = UIImage(named: "image-x")
    }
    
    let noPhotoLabel = UILabel().then {
        $0.text = "사진 없음"
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
    
    let contentsText = UILabel().then {
        $0.text = "내용이 입력되었다!내용이 입력되었다!"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.black
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let nocontentsText = UILabel().then {
        $0.text = "내용 없음"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.textDisabled
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let historyAddButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 160, height: 40)
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.purpleMain?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.masksToBounds = true
    }
    
    let historyAddLabel = UILabel().then {
        $0.text = "히스토리 등록하기"
        $0.font = UIFont.body2Medium
        $0.textColor = UIColor.black
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let historyAddView = UIImageView().then {
        $0.image = UIImage(named: "archive")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        layoutConstraints()
        historyExists()
        photoImageViewUpdate()
        textUpdate()
        
        sideBarButton.addTarget(self, action: #selector(sideBarButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getPlanDetail()
    }
    
    func getPlanDetail() {
        PlanAPI().getPlanDetail(planId: planId) { plans in
            self.planNameText.text = plans.planName
            self.planDateText.text = plans.date
            self.planTimeText.text = plans.time
            self.member1NameLabel.text = plans.members[0]
        }
    }

    func showPlanEditDelBottomSheet() {
        let bottomSheetViewController = PlanEditDelBottomSheetViewController()
        bottomSheetViewController.modalPresentationStyle = .overCurrentContext
        present(bottomSheetViewController, animated: true, completion: nil)
    }

    @objc private func sideBarButtonTapped() {
        showPlanEditDelBottomSheet()
    }

}

extension PlanInfoViewController {
    private func layoutConstraints() {
        view.addSubview(scrollview)
        scrollview.addSubview(contentView)
        applyConstraintsToscrollview()
        
        contentView.addSubview(backButton)
        contentView.addSubview(planInfoLabel)
        contentView.addSubview(sideBarButton)
        applyConstraintsToTopSection()
        
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
        contentView.addSubview(noPhotoImageView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(noPhotoView)
        contentView.addSubview(noPhotoLabel)
        applyConstraintsToPhoto()
        
        contentView.addSubview(contentsLabel)
        contentView.addSubview(contentsView)
        contentView.addSubview(contentsText)
        contentView.addSubview(nocontentsText)
        applyConstraintsToContents()
        
        contentView.addSubview(historyAddButton)
        contentView.addSubview(historyAddView)
        contentView.addSubview(historyAddLabel)
        applyConstraintsToHistory2()
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
    
    func applyConstraintsToTopSection() {
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalTo(contentView.snp.leading).offset(17)
            make.top.equalTo(contentView.snp.top).offset(41)
        }
        planInfoLabel.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.leading.equalTo(backButton.snp.trailing).offset(116)
            make.top.equalTo(contentView.snp.top).offset(41)
        }
        sideBarButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalTo(planInfoLabel.snp.trailing).offset(108)
            make.top.equalTo(contentView.snp.top).offset(40)
        }
    }
    
    func applyConstraintsToPlanName() {
        planNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(44)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        planNameText.snp.makeConstraints { make in
            make.top.equalTo(planNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
            make.bottom.equalTo(grayLine1.snp.top).offset(-1)
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
            make.top.equalTo(grayLine4.snp.bottom).offset(69)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        noPhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(88)
            make.top.equalTo(photoLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(345)
            make.top.equalTo(photoLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(24)
        }
        noPhotoView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(noPhotoImageView.snp.top).offset(24)
            make.leading.equalTo(noPhotoImageView.snp.leading).offset(32)
            make.trailing.equalTo(noPhotoImageView.snp.trailing).offset(-32)
        }
        noPhotoLabel.snp.makeConstraints { make in
            make.width.equalTo(37)
            make.top.equalTo(noPhotoView.snp.bottom).offset(4)
            make.leading.equalTo(noPhotoImageView.snp.leading).offset(25)
            make.trailing.equalTo(noPhotoImageView.snp.trailing).offset(-26)
        }
    }
    
    func applyConstraintsToContents() {
        contentsLabel.snp.makeConstraints { make in
            make.top.equalTo(grayLine4.snp.bottom).offset(205)
            make.leading.equalTo(contentView.snp.leading).offset(24)
        }
        contentsView.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(163)
            make.top.equalTo(contentsLabel.snp.bottom).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.trailing.equalTo(contentView.snp.trailing).offset(-24)
        }
        contentsText.snp.makeConstraints { make in
            make.width.equalTo(295)
            make.top.equalTo(contentsView.snp.top).offset(25)
            make.leading.equalTo(contentsView.snp.leading).offset(25)
            make.trailing.equalTo(contentsView.snp.trailing).offset(-25)
        }
        nocontentsText.snp.makeConstraints { make in
            make.width.equalTo(295)
            make.top.equalTo(contentsView.snp.top).offset(25)
            make.leading.equalTo(contentsView.snp.leading).offset(25)
            make.trailing.equalTo(contentsView.snp.trailing).offset(-25)
        }
    }
    
    func applyConstraintsToHistory2() {
        historyAddButton.snp.makeConstraints { make in
            make.width.equalTo(160)
            make.height.equalTo(40)
            make.top.equalTo(grayLine4.snp.bottom).offset(63)
            make.leading.equalTo(24)
        }
        historyAddView.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(historyAddButton)
            make.leading.equalTo(historyAddButton.snp.leading).offset(20)
        }
        historyAddLabel.snp.makeConstraints { make in
            make.width.equalTo(98)
            make.centerY.equalTo(historyAddButton)
            make.leading.equalTo(historyAddButton.snp.leading).offset(42)
        }
    }
}
extension PlanInfoViewController {
    @objc private func photoAddButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func historyExists() {
        if ishistoryExisted {
            self.historyAddButton.isHidden = false
            self.historyAddView.isHidden = false
            self.historyAddLabel.isHidden = false
        } else {
            self.historyAddButton.isHidden = true
            self.historyAddView.isHidden = true
            self.historyAddLabel.isHidden = true
            photoImageViewUpdate()
            textUpdate()
        }
    }
    
    func photoImageViewUpdate() {
        if isPhotoUploaded {
            noPhotoImageView.isHidden = true
            noPhotoView.isHidden = true
            noPhotoLabel.isHidden = true
            photoImageView.isHidden = false
        } else {
            noPhotoImageView.isHidden = false
            noPhotoView.isHidden = false
            noPhotoLabel.isHidden = false
            photoImageView.isHidden = true
        }
    }
    
    func textUpdate() {
        if isTextUploaded {
            nocontentsText.isHidden = true
            contentsText.isHidden = false
        } else {
            nocontentsText.isHidden = false
            contentsText.isHidden = true
        }
    }
}

