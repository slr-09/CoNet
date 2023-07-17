//
//  CalendarViewController.swift
//  CoNet
//
//  Created by 가은 on 2023/07/13.
//

import FSCalendar
import SnapKit
import Then
import UIKit

class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    // 이전 달로 이동 버튼
    private let prevBtn = UIButton().then {
        $0.setImage(UIImage(named: "prevBtn"), for: .normal)
    }
    // 다음 달로 이동 버튼
    private let nextBtn = UIButton().then {
        $0.setImage(UIImage(named: "nextBtn"), for: .normal)
    }
    
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        
        // week 또는 month
        calendar.scope = .month
        
        calendar.locale = Locale(identifier: "ko_KR")
        
        // 스크롤 가능 여부
        calendar.scrollEnabled = false
        
        // 현재 달의 날짜들만 표기하도록 설정
        calendar.placeholderType = .none
        
        // top 헤더 뷰 설정
        calendar.headerHeight = 26
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerTitleColor = .black
        calendar.appearance.headerTitleFont = UIFont.headline2Bold
        
        // 헤더 좌우 날짜 표시 삭제
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        
        // 요일
        calendar.appearance.weekdayFont = UIFont.body2Medium
        calendar.appearance.weekdayTextColor = .black
        calendar.weekdayHeight = 48
        
        // 날짜
        calendar.appearance.titleTodayColor = UIColor.purpleMain
        calendar.appearance.titleFont = UIFont.body2Bold
        calendar.appearance.todayColor = UIColor.clear
        
        // 선택된 날짜
        calendar.appearance.selectionColor = UIColor.mainSub2
        
        // 일요일 라벨의 textColor를 red로 설정
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.error
        
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setUI()
    }
    
    func setUI() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.equalTo(safeArea.snp.leading).offset(0)
            make.trailing.equalTo(safeArea.snp.trailing).offset(0)
            make.top.equalTo(safeArea.snp.top).offset(0)
        }
        
        view.addSubview(prevBtn)
        prevBtn.snp.makeConstraints { make in
            make.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1)
            make.leading.equalTo(calendarView.calendarHeaderView.snp.leading).offset(20)
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerY.equalTo(calendarView.calendarHeaderView).multipliedBy(1)
            make.trailing.equalTo(calendarView.calendarHeaderView.snp.trailing).offset(-20)
        }
    }
    
}

extension CalendarViewController: FSCalendarDelegateAppearance {
    // 일요일 날짜를 빨간색으로 설정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 오늘 날짜 색은 보라색으로 설정
        if dateFormatter.string(from: Date()) == dateFormatter.string(from: date) {
            return UIColor.purpleMain
        }
        
        // 요일을 나타내는 숫자
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            return UIColor.error
        }
        
        return .black
    }
    
    // 선택된 날짜 색 설정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // 오늘 날짜
        if dateFormatter.string(from: Date()) == dateFormatter.string(from: date) {
            return UIColor.purpleMain
        }
        
        // 요일을 나타내는 숫자
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        // 일요일
        if Calendar.current.shortWeekdaySymbols[day] == "일" {
            return UIColor.error
        }
        
        return .black
    }
//    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
////        print(position)
//        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
//        return cell
//    }
}
