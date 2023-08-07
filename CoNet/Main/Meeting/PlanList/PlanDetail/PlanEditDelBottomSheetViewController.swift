//
//  PlanEditDelBottomSheetViewController.swift
//  CoNet
//
//  Created by 정아현 on 2023/08/06.
//

import SnapKit
import Then
import UIKit

class PlanEditDelBottomSheetViewController: UIViewController {
    let background = UIView().then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    let bottomSheet = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let grayRectangle = UIView().then {
        $0.layer.backgroundColor = UIColor.iconDisabled?.cgColor
        $0.layer.cornerRadius = 1.5
    }
    
    let editButton = UIButton().then { $0.backgroundColor = .clear }
    
    let editView = UIImageView().then {
        $0.image = UIImage(named: "edit")
    }
    
    let editLabel = UILabel().then {
        $0.text = "수정"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.black
    }
    
    let deleteButton = UIButton().then { $0.backgroundColor = .clear }
    
    let delView = UIImageView().then {
        $0.image = UIImage(named: "deleteRed")
    }
    
    let delLabel = UILabel().then {
        $0.text = "삭제"
        $0.font = UIFont.body1Medium
        $0.textColor = UIColor.error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(background)
        view.addSubview(bottomSheet)
        bottomSheet.addSubview(grayRectangle)
        editButton.addSubview(editView)
        editButton.addSubview(editLabel)
        deleteButton.addSubview(delView)
        deleteButton.addSubview(delLabel)
        layoutConstraints()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopUp))
        background.addGestureRecognizer(tapGesture)
        
        editButton.addTarget(self, action: #selector(showPlanEditVC), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(showDeletePlanVC), for: .touchUpInside)
    }
    
    @objc func dismissPopUp() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func showPlanEditVC() {
        let popUpVC = PlanInfoEditViewController()
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.modalTransitionStyle = .crossDissolve
        present(popUpVC, animated: true, completion: nil)
    }
    
    weak var delegate: PlanInfoViewControllerDelegate?
    
    @objc func showDeletePlanVC() {
        dismiss(animated: true) {
            print("삭제")
            self.delegate?.sendDataBack(data: "삭제")
        }
    }
    
    func layoutConstraints() {
        backgroundConstraints()
        componentsConstraints()
    }
    
    func backgroundConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.snp.bottom)
            make.height.equalTo(183)
        }
    }
    
    func componentsConstraints() {
        grayRectangle.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(36)
            make.centerX.equalTo(bottomSheet.snp.centerX)
            make.top.equalTo(bottomSheet.snp.top).offset(10)
        }
        
        bottomSheet.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(grayRectangle.snp.bottom).offset(33)
        }
        editView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(editButton.snp.centerY)
            make.leading.equalTo(bottomSheet.snp.leading).offset(24)
        }
        editLabel.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.centerY.equalTo(editView)
            make.leading.equalTo(editView.snp.trailing).offset(6)
        }
        
        bottomSheet.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(editButton.snp.bottom)
        }
        delView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalTo(deleteButton.snp.centerY)
            make.leading.equalTo(bottomSheet.snp.leading).offset(24)
        }
        delLabel.snp.makeConstraints { make in
            make.width.equalTo(28)
            make.centerY.equalTo(delView)
            make.leading.equalTo(editView.snp.trailing).offset(6)
        }
    }
}
