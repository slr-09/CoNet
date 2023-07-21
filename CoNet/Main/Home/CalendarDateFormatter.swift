//
//  CalendarDateFormatter.swift
//  CoNet
//
//  Created by 가은 on 2023/07/21.
//

import Foundation

class CalendarDateFormatter {
    private let calendar = Calendar.current // Calendar 구조체를 현재 달력으로 초기화
    private let dateFormatter = DateFormatter() // 원하는 String 타입으로 변화시켜줄 formatter
    private var nowCalendarDate = Date() // 현재 시간
    private(set) var days = [String]() // 달력에 표시할 날짜를 담을 배열
    
    init() {
        configureCalendar()
    }
    
    // year, month text
    func getYearMonthText() -> String {
        let yearMonthText = dateFormatter.string(from: nowCalendarDate)
        
        return yearMonthText
    }
    
    func updateCurrentMonthDays() {
        days.removeAll()
        
        // 1일 요일
        let startDayOfWeek = getStartingDayOfWeek()
        let totalDaysOfMonth = startDayOfWeek + getEndDateOfMonth()
        
        for day in 0 ..< totalDaysOfMonth {
            if day < startDayOfWeek {
                days.append("")
                continue
            }
            days.append("\(day - startDayOfWeek + 1)")
        }
    }
}

private extension CalendarDateFormatter {
    // 해당 달의 1일 요일 반환
    func getStartingDayOfWeek() -> Int {
        return calendar.component(.weekday, from: nowCalendarDate) - 1
    }
    
    // 해당 달의 날짜가 며칠까지 있는지 반환
    func getEndDateOfMonth() -> Int {
        return calendar.range(of: .day, in: .month, for: nowCalendarDate)?.count ?? 0
    }
    
    func configureCalendar() {
        let components = calendar.dateComponents([.year, .month], from: Date())
        nowCalendarDate = calendar.date(from: components) ?? Date()
        dateFormatter.dateFormat = "yyyy년 MM월"
    }
}
