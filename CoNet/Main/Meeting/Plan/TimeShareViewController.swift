//
//  TimeShareViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/27.
//

import SnapKit
import Then
import UIKit

class TimeShareViewController: UIViewController {
    // x 버튼
    let xButton = UIButton().then {
        $0.setImage(UIImage(named: "closeBtn"), for: .normal)
    }
    
    // 약속 이름
    let planTitle = UILabel().then {
        $0.text = "약속 이름"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.textHigh
    }
    
    // 점 3개 버튼 (약속 수정/삭제 bottom sheet 나오는 버튼)
    let dots = UIButton().then {
        $0.setImage(UIImage(named: "sidebar"), for: .normal)
    }
    
    // 이전 날짜로 이동 버튼
    let prevBtn = UIButton().then {
        $0.setImage(UIImage(named: "planPrevBtn"), for: .normal)
    }
    
    // 날짜 3개
    let date1 = UILabel().then {
        $0.text = "07. 03 월"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
        $0.textAlignment = .center
    }

    let date2 = UILabel().then {
        $0.text = "07. 04 화"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
        $0.textAlignment = .center
    }

    let date3 = UILabel().then {
        $0.text = "07. 05 수"
        $0.font = UIFont.body2Bold
        $0.textColor = UIColor.textHigh
        $0.textAlignment = .center
    }
    
    // 다음 날짜로 이동 버튼
    let nextBtn = UIButton().then {
        $0.setImage(UIImage(named: "planNextBtn"), for: .normal)
    }
    
    // 타임테이블
    let timeTable = TimeTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutConstraints()
        timeTableSetting()
    }
    
    func timeTableSetting() {
        timeTable.timeTableCollectionView.dataSource = self
        timeTable.timeTableCollectionView.delegate = self
    }
    
    func layoutConstraints() {
        headerConstraintS()
        timetableConstraints()
    }

    // 헤더 - x버튼, 약속 이름 등
    func headerConstraintS() {
        let safeArea = view.safeAreaLayoutGuide
        
        // x 버튼
        view.addSubview(xButton)
        xButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.top.equalTo(safeArea.snp.top).offset(40)
        }
        
        // 약속 이름
        view.addSubview(planTitle)
        planTitle.snp.makeConstraints { make in
            make.top.equalTo(safeArea.snp.top).offset(41)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        // dots 버튼
        view.addSubview(dots)
        dots.snp.makeConstraints { make in
            make.trailing.equalTo(safeArea.snp.trailing).offset(-24)
            make.top.equalTo(safeArea.snp.top).offset(40)
        }
    }
    
    // time table
    func timetableConstraints() {
        // 이전 날짜로 이동 버튼
        view.addSubview(prevBtn)
        prevBtn.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(view.snp.leading).offset(44)
            make.top.equalTo(xButton.snp.bottom).offset(29)
        }
        
        // 날짜 3개
        view.addSubview(date1)
        date1.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.leading.equalTo(prevBtn.snp.trailing).offset(10)
            make.centerY.equalTo(prevBtn.snp.centerY)
        }
        view.addSubview(date2)
        date2.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.leading.equalTo(date1.snp.trailing).offset(20)
            make.centerY.equalTo(prevBtn.snp.centerY)
        }
        view.addSubview(date3)
        date3.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.leading.equalTo(date2.snp.trailing).offset(20)
            make.centerY.equalTo(prevBtn.snp.centerY)
        }
        
        // 다음 날짜로 이동 버튼
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(date3.snp.trailing).offset(9)
            make.top.equalTo(dots.snp.bottom).offset(29)
        }
        
        // 타임테이블
        view.addSubview(timeTable)
        timeTable.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(timeTable.snp.leading).offset(300)
            make.top.equalTo(prevBtn.snp.bottom).offset(7)
            make.bottom.equalToSuperview()
        }
    }
}

extension TimeShareViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 셀 클릭 시 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
        
        
    }
    
    // 셀 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24*3
    }
    
    // 셀 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 24)
    }
    
    // 위 아래 space zero로 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -1
    }
    
    // 양옆 space zero로 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}
