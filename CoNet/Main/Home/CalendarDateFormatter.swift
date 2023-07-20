//
//  CalendarDateFormatter.swift
//  CoNet
//
//  Created by 가은 on 2023/07/21.
//

import Foundation

class CalendarDateFormatter {
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()
    private var nowCalendarDate = Date()    // 현재 시간
    private(set) var days = [String]()
    
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
        
        for day in 0..<totalDaysOfMonth {
            if day < startDayOfWeek {
                days.append("")
            } else {
                days.append("\(day - startDayOfWeek + 1)")
            }
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
