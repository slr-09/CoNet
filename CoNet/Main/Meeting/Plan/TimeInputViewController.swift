//
//  TimeInputViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/28.
//

import UIKit

class TimeInputViewController: UIViewController {
    // 이전 화면 버튼
    let prevButton = UIButton().then {
        $0.setImage(UIImage(named: "prevBtn"), for: .normal)
    }
    
    // 내 시간 입력하기 label
    let inputTimeLabel = UILabel().then {
        $0.text = "내 시간 입력하기"
        $0.font = UIFont.headline3Bold
        $0.textColor = UIColor.textHigh
    }
    
    // 이전 날짜로 이동 버튼
    let prevDayBtn = UIButton().then {
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
    let nextDayBtn = UIButton().then {
        $0.setImage(UIImage(named: "planNextBtn"), for: .normal)
    }
    
    // 타임테이블
    let timeTable = TimeTableView()
    
    // 가능한 시간 없음 버튼
    let timeImpossibleButton = UIButton().then {
        $0.setImage(UIImage(named: "timeImpossible"), for: .normal)
    }
    
    // 가능한 시간 없음 label
    let timeImpossibleLabel = UILabel().then {
        $0.text = "가능한 시간 없음"
        $0.textColor = UIColor.textDisabled
        $0.font = UIFont.overline
    }
    
    // 저장 버튼
    let saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.titleLabel?.textColor = UIColor.white
        $0.titleLabel?.font = UIFont.body1Medium
        $0.backgroundColor = UIColor.gray200
        $0.layer.cornerRadius = 12
    }
    
    // 가능한 시간 없음 버튼 클릭 여부 체크
    var possibleTimeCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        layoutConstraints()
        timeTableSetting()
        
        btnClickEvents()
    }
    
    // 버튼 클릭 이벤트 
    func btnClickEvents() {
        prevButton.addTarget(self, action: #selector(didClickPrevButton), for: .touchUpInside)
        timeImpossibleButton.addTarget(self, action: #selector(didClickTimeImpossibleButton), for: .touchUpInside)
    }
    
    // 이전 버튼 클릭 시 창 끄기
    @objc func didClickPrevButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 가능한 시간 없음 버튼 클릭 시
    // possibleTimeCheck: true/false
    @objc func didClickTimeImpossibleButton() {
        possibleTimeCheck = !possibleTimeCheck
        timeTable.timeTableCollectionView.reloadData()
        
        if possibleTimeCheck {
            timeImpossibleButton.setImage(UIImage(named: "timeImpossibleSelected"), for: .normal)
            timeImpossibleLabel.textColor = UIColor.purpleMain
        } else {
            timeImpossibleButton.setImage(UIImage(named: "timeImpossible"), for: .normal)
            timeImpossibleLabel.textColor = UIColor.textDisabled
        }
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
        view.addSubview(prevButton)
        prevButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.leading.equalTo(safeArea.snp.leading).offset(24)
            make.top.equalTo(safeArea.snp.top).offset(30)
        }
        
        // 약속 이름
        view.addSubview(inputTimeLabel)
        inputTimeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(prevButton)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    // time table
    func timetableConstraints() {
        // 이전 날짜로 이동 버튼
        view.addSubview(prevDayBtn)
        prevDayBtn.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(view.snp.leading).offset(44)
            make.top.equalTo(prevButton.snp.bottom).offset(29)
        }
        
        // 날짜 3개
        view.addSubview(date1)
        date1.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.leading.equalTo(prevDayBtn.snp.trailing).offset(10)
            make.centerY.equalTo(prevDayBtn.snp.centerY)
        }
        view.addSubview(date2)
        date2.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.leading.equalTo(date1.snp.trailing).offset(20)
            make.centerY.equalTo(prevDayBtn.snp.centerY)
        }
        view.addSubview(date3)
        date3.snp.makeConstraints { make in
            make.width.equalTo(59)
            make.leading.equalTo(date2.snp.trailing).offset(20)
            make.centerY.equalTo(prevDayBtn.snp.centerY)
        }
        
        // 다음 날짜로 이동 버튼
        view.addSubview(nextDayBtn)
        nextDayBtn.snp.makeConstraints { make in
            make.height.width.equalTo(16)
            make.leading.equalTo(date3.snp.trailing).offset(9)
            make.centerY.equalTo(prevDayBtn.snp.centerY)
        }
        
        view.addSubview(timeTable)
        view.addSubview(saveButton)
        
        // 저장 버튼
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(24)
            make.bottom.equalTo(view.snp.bottom).offset(-35)
        }
        
        // 타임테이블
        timeTable.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(timeTable.snp.leading).offset(300)
            make.top.equalTo(prevDayBtn.snp.bottom).offset(7)
            make.bottom.equalTo(saveButton.snp.top).offset(-10)
        }
        
        // 가능한 시간 없음 버튼
        view.addSubview(timeImpossibleButton)
        timeImpossibleButton.snp.makeConstraints { make in
            make.leading.equalTo(timeTable.snp.trailing).offset(18)
            make.top.equalTo(nextDayBtn.snp.bottom).offset(507)
        }
        
        // 가능한 시간 없음 label
        view.addSubview(timeImpossibleLabel)
        timeImpossibleLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.leading.equalTo(timeTable.snp.trailing).offset(7)
            make.top.equalTo(timeImpossibleButton.snp.bottom).offset(5)
        }
    }
}

extension TimeInputViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 셀 클릭 시 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
        
        // 가능한 시간 없은 버튼 체크하지 않은 경우만
        if !possibleTimeCheck {
            // change cell background color
            let cell  = collectionView.cellForItem(at: indexPath) as! TimeTableViewCell
            cell.changeCellColor()
        }
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
        return -1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeTableViewCell.identifier, for: indexPath) as? TimeTableViewCell else { return UICollectionViewCell() }
        
        // 가능한 시간 없음 버튼 클릭 여부 체크
        if possibleTimeCheck {
            cell.contentView.backgroundColor = UIColor.gray50
        } else {
            cell.contentView.backgroundColor = .white
        }
        
        return cell
    }
}
