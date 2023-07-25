//
//  HistoryBottomSheetViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/25.
//

import SnapKit
import Then
import UIKit

class HistoryBottomSheetViewController: UIViewController {
    // 배경 - black 투명도 30%
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    // bottom sheet (흰 배경)
    let bottomSheet = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let grayRectangle = UIView().then {
        $0.layer.backgroundColor = UIColor.iconDisabled?.cgColor
        $0.layer.cornerRadius = 1.5
    }
    
    // 수정 이미지
    let editImage = UIImageView().then {
        $0.image = UIImage(named: "edit")
    }
    
    // 수정 label
    let editLabel = UILabel().then {
        $0.text = "수정"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.textHigh
    }
    
    // 삭제 이미지
    let deleteImage = UIImageView().then {
        $0.image = UIImage(named: "deleteRed")
    }
    
    // 삭제 label
    let deleteLabel = UILabel().then {
        $0.text = "삭제"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutConstraints()
        
        // 배경 탭
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
    }
    
    // 배경 탭 시 팝업 닫기
    @objc func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
    
    func layoutConstraints() {
        backgroundConstraints()
        componentsConstraints()
    }
    
    func backgroundConstraints() {
        // 불투명 배경
        view.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // bottom sheet
        view.addSubview(bottomSheet)
        bottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(173)
        }
    }
    
    func componentsConstraints() {
        bottomSheet.addSubview(grayRectangle)
        grayRectangle.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(36)
            make.centerX.equalTo(bottomSheet.snp.centerX)
            make.top.equalTo(bottomSheet.snp.top).offset(10)
        }
        
        // edit 이미지
        bottomSheet.addSubview(editImage)
        editImage.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalTo(bottomSheet.snp.leading).offset(24)
            make.top.equalTo(bottomSheet.snp.top).offset(46)
        }
        
        // edit label
        bottomSheet.addSubview(editLabel)
        editLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(editImage.snp.trailing).offset(6)
            make.centerY.equalTo(editImage.snp.centerY)
        }
        
        // delete 이미지
        bottomSheet.addSubview(deleteImage)
        deleteImage.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalTo(bottomSheet.snp.leading).offset(24)
            make.top.equalTo(editImage.snp.bottom).offset(26)
        }
        
        // edit label
        bottomSheet.addSubview(deleteLabel)
        deleteLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.leading.equalTo(deleteImage.snp.trailing).offset(6)
            make.centerY.equalTo(deleteImage.snp.centerY)
        }
    }
}
