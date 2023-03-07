//
//  Date+Today.swift
//  Today
//
//  Created by 강창현 on 2023/03/07.
//

import Foundation

extension Date {
    var dayAndTimeText: String {
        // .omitted: date 시간 구성 요소만 포함된 문자열 생성
        let timeText = formatted(date: .omitted, time: .shortened)
        // 사용자에게 현지화된 문자열 표시에 대한 컨텍스트를 번역자에게 제공
        if Locale.current.calendar.isDateInToday(self) {
            let timeFormat = NSLocalizedString("Today at %@", comment: "Today at time format string")
            return String(format: timeFormat, timeText)
        } else {
            let dateText = formatted(.dateTime.month(.abbreviated).day())
            let dateAndTimeFormat = NSLocalizedString("%@ at %@", comment: "Date and time format string")
            return String(format: dateAndTimeFormat, dateText, timeText)
        }
    }
    
    var dayText: String {
        if Locale.current.calendar.isDateInToday(self) {
            return NSLocalizedString("Today", comment: "Today due date description")
        } else {
            // 월, 일 및 요일만 포함하는 사용자 지정 날짜 스타일을 허용
            return formatted(.dateTime.month().day().weekday(.wide))
        }
    }
}
