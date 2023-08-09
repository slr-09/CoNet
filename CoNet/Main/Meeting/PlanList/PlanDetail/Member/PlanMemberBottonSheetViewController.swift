//
//  PlanMemberBottonSheetViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/07/28.
//

import SnapKit
import Then
import UIKit

class PlanMemberBottomSheetViewController: UIViewController {
    var members: [PlanDetailMember] = []
    
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    let bottomSheet = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let grayLine = UIView().then {
        $0.layer.backgroundColor = UIColor.iconDisabled?.cgColor
        $0.layer.cornerRadius = 1.5
    }
    
    let member1ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member1NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }
    
    let member1CheckButton = UIButton().then {
        $0.setImage(UIImage(named: "checkCircle"), for: .normal)
    }
    
    let member2ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member2NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }
    
    let member2CheckButton = UIButton().then {
        $0.setImage(UIImage(named: "checkCircle"), for: .normal)
    }
    
    let member3ImageView = UIImageView().then {
        $0.image = UIImage(named: "defaultProfile")
    }
    
    let member3NameLabel = UILabel().then {
        $0.text = "참여자 이름"
        $0.font = UIFont.body2Medium
    }
    
    let member3CheckButton = UIButton().then {
        $0.setImage(UIImage(named: "checkCircle"), for: .normal)
    }
    
    var isMember1Checked = false
    var isMember2Checked = false
    var isMember3Checked = false
    
    let addButton = UIButton().then {
        $0.frame = CGRect(x: 0, y: 0, width: 345, height: 52)
        $0.backgroundColor = UIColor.iconDisabled
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("추가하기", for: .normal)
        $0.titleLabel?.font = UIFont.body1Medium
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view.addSubview(background)
        view.addSubview(bottomSheet)
        bottomSheet.addSubview(grayLine)
        bottomSheet.addSubview(member1ImageView)
        bottomSheet.addSubview(member1NameLabel)
        bottomSheet.addSubview(member1CheckButton)
        bottomSheet.addSubview(member2ImageView)
        bottomSheet.addSubview(member2NameLabel)
        bottomSheet.addSubview(member2CheckButton)
        bottomSheet.addSubview(member3ImageView)
        bottomSheet.addSubview(member3NameLabel)
        bottomSheet.addSubview(member3CheckButton)
        bottomSheet.addSubview(addButton)
        applyConstraintsToBackground()
        applyConstraintsToComponents()
        
        member1CheckButton.addTarget(self, action: #selector(member1CheckButtonTapped), for: .touchUpInside)
        member2CheckButton.addTarget(self, action: #selector(member2CheckButtonTapped), for: .touchUpInside)
        member3CheckButton.addTarget(self, action: #selector(member3CheckButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
    
    func applyConstraintsToBackground() {
        let safeArea = view.safeAreaLayoutGuide
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomSheet.snp.makeConstraints { make in
            make.height.equalTo(337)
            make.top.equalTo(safeArea.snp.top).offset(471)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
    func applyConstraintsToComponents() {
        let safeArea = view.safeAreaLayoutGuide
        grayLine.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(3)
            make.top.equalTo(bottomSheet.snp.top).offset(10)
            make.leading.equalTo(bottomSheet.snp.leading).offset(179)
            make.trailing.equalTo(bottomSheet.snp.trailing).offset(-178)
        }
        member1ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(grayLine.snp.bottom).offset(45)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        member1NameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member1ImageView.snp.trailing).offset(10)
        }
        member1CheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(member1ImageView)
            make.leading.equalTo(member1ImageView.snp.trailing).offset(107)
        }
        member2ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(grayLine.snp.bottom).offset(45)
            make.leading.equalTo(member1CheckButton.snp.trailing).offset(15)
        }
        member2NameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(member2ImageView)
            make.leading.equalTo(member2ImageView.snp.trailing).offset(10)
        }
        member2CheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(member2ImageView)
            make.leading.equalTo(member2ImageView.snp.trailing).offset(107)
        }
        member3ImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalTo(member1ImageView.snp.bottom).offset(10)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
        }
        member3NameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(member3ImageView)
            make.leading.equalTo(member3ImageView.snp.trailing).offset(10)
        }
        member3CheckButton.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.centerY.equalTo(member3ImageView)
            make.leading.equalTo(member3ImageView.snp.trailing).offset(107)
        }
        addButton.snp.makeConstraints { make in
            make.width.equalTo(345)
            make.height.equalTo(44)
            make.top.equalTo(member3ImageView.snp.bottom).offset(96)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
        }
    }
    
    @objc func member1CheckButtonTapped() {
        isMember1Checked.toggle()
        member1CheckButton.setImage(UIImage(named: isMember1Checked ? "checkCircle2" : "checkCircle"), for: .normal)
        updateAddButtonBackgroundColor()
    }

    @objc func member2CheckButtonTapped() {
        isMember2Checked.toggle()
        member2CheckButton.setImage(UIImage(named: isMember2Checked ? "checkCircle2" : "checkCircle"), for: .normal)
        updateAddButtonBackgroundColor()
    }

    @objc func member3CheckButtonTapped() {
        isMember3Checked.toggle()
        member3CheckButton.setImage(UIImage(named: isMember3Checked ? "checkCircle2" : "checkCircle"), for: .normal)
        updateAddButtonBackgroundColor()
    }
    
    func updateAddButtonBackgroundColor() {
        if isMember1Checked || isMember2Checked || isMember3Checked {
            addButton.backgroundColor = .purple
        } else {
            addButton.backgroundColor = UIColor.iconDisabled
        }
    }

    @objc func addButtonTapped() {
        // "추가하기" 버튼을 눌렀을 때 수행할 동작
    }
}
