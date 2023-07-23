//
//  HomeViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/08.
//

import SnapKit
import Then
import UIKit

class HomeViewController: UIViewController {
    
    // 스크롤뷰
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    
    // 컴포넌트들이 들어갈 뷰
    let contentView = UIView()
    
    let calendarView = CalendarView().then {
        $0.layer.borderWidth = 0.2
        $0.layer.borderColor = UIColor.gray300?.cgColor
    }
    
    // label: 오늘의 약속
    let dayPlanLabel = UILabel().then {
        $0.text = "오늘의 약속"
        $0.font = UIFont.headline2Bold
    }
    
    let planNumCircle = UIImageView().then {
        $0.image = UIImage(named: "purpleLineCircle")
    }
    
    // 약속 수
    let planNum = UILabel().then {
        $0.text = "2"
        $0.textColor = UIColor.purpleMain
        $0.font = UIFont.body3Bold
    }
    
    // 오늘 약속 collectionView
    private lazy var dayPlanCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.isScrollEnabled = false
    }
    
    // 오늘 약속 데이터 
    private let dayPlanData = PlanDummyData.dayPlanData
    
    // label: 대기 중 약속
    let waitingPlanLabel = UILabel().then {
        $0.text = "대기 중인 약속"
        $0.font = UIFont.headline2Bold
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        // navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        // layout
        addView()
        layoutConstraints()
        
        calendarView.yearMonth.addTarget(self, action: #selector(didClickYearBtn), for: .touchUpInside)
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        // 오늘 약속 collectionView
        dayPlanCollectionView.delegate = self
        dayPlanCollectionView.dataSource = self
        dayPlanCollectionView.register(DayPlanCell.self, forCellWithReuseIdentifier: DayPlanCell.registerId)
    }
    
    // yearMonth 클릭
    @objc func didClickYearBtn(_ sender: UIView) {
        let popupVC = MonthViewController()
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        present(popupVC, animated: true, completion: nil)
    }
    
    func addView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(calendarView)
        contentView.addSubview(dayPlanLabel)
        contentView.addSubview(planNumCircle)
        contentView.addSubview(planNum)
        contentView.addSubview(dayPlanCollectionView)
//        contentView.addSubview(dayPlanTableView)
        contentView.addSubview(waitingPlanLabel)
    }
    
    // layout
    func layoutConstraints() {
        // 안전 영역
        let safeArea = view.safeAreaLayoutGuide
        
        // 스크롤뷰
        scrollView.snp.makeConstraints { make in
            make.leading.equalTo(safeArea.snp.leading).offset(0)
            make.trailing.equalTo(safeArea.snp.trailing).offset(0)
            make.top.equalTo(safeArea.snp.top).offset(0)
            make.bottom.equalTo(safeArea.snp.bottom).offset(0)
        }
        
        // 컴포넌트들이 들어갈 뷰
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(1000) // 높이를 설정해야 스크롤이 됨
        }
        
        // 캘린더 뷰
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(43)
            make.leading.equalTo(contentView.snp.leading).offset(0)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
            make.height.equalTo(448)
        }
        
        // label: 오늘의 약속
        dayPlanLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.top.equalTo(calendarView.snp.bottom).offset(36)
        }
        
        planNumCircle.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(dayPlanLabel.snp.trailing).offset(6)
            make.top.equalTo(calendarView.snp.bottom).offset(39)
        }
        
        // label: 약속 수
        planNum.snp.makeConstraints { make in
            make.centerY.equalTo(planNumCircle.snp.centerY)
            make.centerX.equalTo(planNumCircle.snp.centerX)
        }
        
        // collectionView: 오늘의 약속
        dayPlanCollectionView.snp.makeConstraints { make in
            make.top.equalTo(dayPlanLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(dayPlanData.count*92)
//            make.bottom.equalToSuperview()
        }
        
        // label: 대기 중 약속
//        waitingPlanLabel.snp.makeConstraints { make in
//            make.leading.equalTo(contentView.snp.leading).offset(0)
//            make.top.equalTo(dayPlanCollectionView.snp.bottom).offset(50)
//        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 각 셀을 클릭했을 때 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
    }
    
    // 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayPlanData.count
    }
    
    // 셀
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayPlanCell.registerId, for: indexPath) as? DayPlanCell else {
            return UICollectionViewCell()
        }
        
        cell.timeLabel.text = dayPlanData[indexPath.item].time
        cell.planTitleLabel.text = dayPlanData[indexPath.item].planTitle
        cell.groupNameLabel.text = dayPlanData[indexPath.item].groupName
        
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize.init(width: width, height: 82)
    }
    
    // 셀 사이의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

