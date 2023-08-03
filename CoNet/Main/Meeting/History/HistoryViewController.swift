//
//  HistoryViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/23.
//

import SnapKit
import Then
import UIKit

class HistoryViewController: UIViewController {
    // x 버튼
    let xBtn = UIImageView().then {
        $0.image = UIImage(named: "closeBtn")
    }
    
    // label: 히스토리
    let historyLabel = UILabel().then {
        $0.text = "히스토리"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.textHigh
    }
    
    // 추가 버튼
    let addBtn = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.titleLabel?.font = UIFont.headline3Medium
        $0.setTitleColor(UIColor.purpleMain, for: .normal)
    }
    
    // collectionView: history
    let historyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        layoutConstraints()
        collectionViewSetting()
    }
    
    // history collectionView setting
    func collectionViewSetting() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        historyCollectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
    }
    
    func layoutConstraints() {
        backgroundConstraints()
        historyConstraints()
    }
    
    func backgroundConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        // x 버튼
        view.addSubview(xBtn)
        xBtn.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.top.equalTo(safeArea.snp.top).offset(41)
        }
        
        // label: 히스토리
        view.addSubview(historyLabel)
        historyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeArea.snp.centerX)
            make.centerY.equalTo(xBtn.snp.centerY)
        }
        
        // 추가 버튼
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.centerY.equalTo(xBtn.snp.centerY)
        }
    }
    
    func historyConstraints() {
        // collectionView: history
        view.addSubview(historyCollectionView)
        historyCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(historyLabel.snp.bottom).offset(30)
            make.height.equalTo(1000)
        }
    }
    
    // 수정&삭제 bottom sheet 보여주기
    @objc func showBottomSheet() {
        let popupVC = HistoryBottomSheetViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
}

extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 각 셀을 클릭했을 때 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
    }
    
    // 셀 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 500)
    }
    
    // 셀 사이의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 80
    }
}
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        HistoryViewController().showPreview(.iPhone14Pro)
    }
}
#endif
