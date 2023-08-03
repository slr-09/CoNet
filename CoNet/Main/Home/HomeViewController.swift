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
    
    // logo
    let logoImage = UIImageView().then {
        $0.image = UIImage(named: "homeConetLogo")
    }
    
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
    
    let calendarVC = CalendarViewController()
    
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
    var dayPlanData: [Plan] = []
    
    // label: 대기 중 약속
    let waitingPlanLabel = UILabel().then {
        $0.text = "대기 중인 약속"
        $0.font = UIFont.headline2Bold
    }
    
    let planNumCircle2 = UIImageView().then {
        $0.image = UIImage(named: "purpleLineCircle")
    }
    
    // 약속 수
    let waitingPlanNum = UILabel().then {
        $0.text = "2"
        $0.textColor = UIColor.purpleMain
        $0.font = UIFont.body3Bold
    }
    
    // 대기 중 약속 collectionView
    private lazy var waitingPlanCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.isScrollEnabled = false
        $0.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    // 대기 중 약속 데이터
    private var waitingPlanData: [WaitingPlan] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // background color를 white로 설정 (default: black)
        view.backgroundColor = .white
        // navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
        
        // layout
        addView()
        layoutConstraints()
        
        // HomeViewController의 인스턴스를 CalendarViewController의 프로퍼티에 할당
        calendarVC.homeVC = self
        
        calendarVC.yearMonth.addTarget(self, action: #selector(didClickYearBtn), for: .touchUpInside)
        
        setupCollectionView()
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        dayPlanAPI(date: format.string(from: Date()))
        
        // api: 대기 중인 약속
        HomeAPI().getWaitingPlan { count, plans in
            self.waitingPlanNum.text = String(count)
            self.waitingPlanData = plans
            self.waitingPlanCollectionView.reloadData()
        }
    }
    
    // 특정 날짜 약속 조회 api 함수
    func dayPlanAPI(date: String) {
        // api: 특정 날짜 약속
        HomeAPI().getDayPlan(date: date) { count, plans in
            self.planNum.text = String(count)
            self.dayPlanData = plans
            self.dayPlanCollectionView.reloadData()
        }
    }
    
    private func setupCollectionView() {
        // 오늘 약속 collectionView
        dayPlanCollectionView.delegate = self
        dayPlanCollectionView.dataSource = self
        dayPlanCollectionView.register(DayPlanCell.self, forCellWithReuseIdentifier: DayPlanCell.registerId)
        
        // 대기 중 약속 collectionView
        waitingPlanCollectionView.delegate = self
        waitingPlanCollectionView.dataSource = self
        waitingPlanCollectionView.register(ShadowWaitingPlanCell.self, forCellWithReuseIdentifier: ShadowWaitingPlanCell.registerId)
        
        // 캘린더 뷰
//        calendarVC.calendarCollectionView.delegate = self
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
        contentView.addSubview(logoImage)
//        contentView.addSubview(calendarView)
        addChild(calendarVC)
        contentView.addSubview(calendarVC.view)
        contentView.addSubview(dayPlanLabel)
        contentView.addSubview(planNumCircle)
        contentView.addSubview(planNum)
        contentView.addSubview(dayPlanCollectionView)
        contentView.addSubview(waitingPlanLabel)
        contentView.addSubview(planNumCircle2)
        contentView.addSubview(waitingPlanNum)
        contentView.addSubview(waitingPlanCollectionView)
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
        
        let backgroundHeight = 657 + dayPlanData.count*82 + waitingPlanData.count*92
        
        // 컴포넌트들이 들어갈 뷰
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(backgroundHeight) // 높이를 설정해야 스크롤이 됨
        }
        
        // logo
        logoImage.snp.makeConstraints { make in
            make.width.equalTo(91)
            make.height.equalTo(30)
            make.leading.equalTo(contentView.snp.leading).offset(26)
            make.top.equalTo(contentView.snp.top).offset(8)
        }
        
        // 캘린더 뷰
//        calendarView.snp.makeConstraints { make in
//            make.top.equalTo(logoImage.snp.bottom).offset(5)
//            make.leading.equalTo(contentView.snp.leading).offset(0)
//            make.trailing.equalTo(contentView.snp.trailing).offset(0)
//            make.height.equalTo(448)
//        }
        
        calendarVC.didMove(toParent: self)
        calendarVC.view.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(5)
            make.leading.equalTo(contentView.snp.leading).offset(0)
            make.trailing.equalTo(contentView.snp.trailing).offset(0)
            make.height.equalTo(448)
        }
        
        // label: 오늘의 약속
        dayPlanLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.top.equalTo(calendarVC.view.snp.bottom).offset(36)
        }
        
        planNumCircle.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(dayPlanLabel.snp.trailing).offset(6)
            make.centerY.equalTo(dayPlanLabel.snp.centerY)
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
            make.height.equalTo(dayPlanData.count*92 - 10)
        }
        
        // label: 대기 중 약속
        waitingPlanLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(24)
            make.top.equalTo(dayPlanCollectionView.snp.bottom).offset(50)
        }
        
        planNumCircle2.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.leading.equalTo(waitingPlanLabel.snp.trailing).offset(6)
            make.centerY.equalTo(waitingPlanLabel.snp.centerY)
        }
        
        // label: 대기 중인 약속 수
        waitingPlanNum.snp.makeConstraints { make in
            make.centerY.equalTo(planNumCircle2.snp.centerY)
            make.centerX.equalTo(planNumCircle2.snp.centerX)
        }
        
        // collectionView: 대기 중 약속
        waitingPlanCollectionView.snp.makeConstraints { make in
            make.top.equalTo(waitingPlanLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(waitingPlanData.count * 92)
        }
    }
    
    // change day label
    func changeDate(month: String, day: String) {
        if month == "" && day == "" {
            dayPlanLabel.text = "오늘의 약속"
        } else {
            dayPlanLabel.text = month + "월 " + day + "일의 약속"
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // 각 셀을 클릭했을 때 이벤트 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at indexPath: \(indexPath)")
        
//        if collectionView == calendarVC.calendarCollectionView {
//            // 캘린더 날짜
//            let yeMo = calendarView.calendarDateFormatter.getYearMonthText()
//            let calendarDay = calendarView.calendarDateFormatter.days[indexPath.item]
//
//            var day = calendarDay
//            if calendarDay.count == 1 {
//                day = "0" + calendarDay
//            }
//
//            // 날짜 포멧 바꾸기
//            var calendarDate = yeMo + " " + day + "일"
//
//            let format = DateFormatter()
//            format.dateFormat = "yyyy년 MM월 dd일"
//            format.locale = Locale(identifier: "ko_KR")
//            format.timeZone = TimeZone(abbreviation: "KST")
//
//            let today = format.string(from: Date())
//
//            // 선택한 날짜가 오늘일 때
//            // 날짜 label 변경
//            if today == calendarDate {
//                changeDate(month: "", day: "")
//            } else {
//
//                changeDate(month: calendarView.calendarDateFormatter.getMonthText(), day: calendarDay)
//            }
//
//            // 선택 날짜 포맷 변경
//            calendarDate = calendarDate.replacingOccurrences(of: "년 ", with: "-")
//            calendarDate = calendarDate.replacingOccurrences(of: "월 ", with: "-")
//            calendarDate = calendarDate.replacingOccurrences(of: "일", with: "")
//
//            // api: 특정 날짜 약속
//            dayPlanAPI(date: calendarDate)
//        }
    }
    
    // 셀 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        if collectionView == dayPlanCollectionView {    // 오늘 약속
            count = dayPlanData.count
        } else if collectionView == waitingPlanCollectionView { // 대기 중 약속
            count = waitingPlanData.count
        }
//        else if collectionView == calendarView.calendarCollectionView {   // 캘린더
//            count = calendarView.calendarDateFormatter.days.count
//        }
        
        return count
    }
    
    // 셀
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dayPlanCollectionView {
            // 오늘 약속
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayPlanCell.registerId, for: indexPath) as? DayPlanCell else {
                return UICollectionViewCell()
            }
            
            cell.timeLabel.text = self.dayPlanData[indexPath.item].time
            cell.planTitleLabel.text = self.dayPlanData[indexPath.item].planName
            cell.groupNameLabel.text = self.dayPlanData[indexPath.item].teamName
            
            return cell
        } else if collectionView == waitingPlanCollectionView {
            // 대기 중 약속
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShadowWaitingPlanCell.registerId, for: indexPath) as? ShadowWaitingPlanCell else {
                return UICollectionViewCell()
            }
            
            cell.startDateLabel.text = waitingPlanData[indexPath.item].startDate
            cell.finishDateLabel.text = waitingPlanData[indexPath.item].endDate
            cell.planTitleLabel.text = waitingPlanData[indexPath.item].planName
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 24
        
//        if collectionView == calendarView.calendarCollectionView {  // 캘린더
//            let width = calendarView.weekStackView.frame.width / 7
//            return CGSize(width: width, height: 50)
//        }
        
        return CGSize(width: width, height: 82)
    }
    
    // 셀 사이의 위아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if collectionView == calendarView.calendarCollectionView {  // 캘린더
//            return .zero
//        }
        return 10
    }
    
    // 양옆 space zero로 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
