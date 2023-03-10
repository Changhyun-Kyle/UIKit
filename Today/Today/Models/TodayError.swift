//
//  TodayError.swift
//  Today
//
//  Created by 강창현 on 2023/03/10.
//

import Foundation

enum TodayError: LocalizedError {
    case accessDenied
    case accessRestricted
    case failureReadingCalendarItem
    case failedReadingReminders
    case remindersHasNotDueDate
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .accessDenied:
            return NSLocalizedString("The app doesn't have permission to read reminders.", comment: "access denied error description")
        case .accessRestricted:
            return NSLocalizedString("This device doesn't allow access to reminders.", comment: "access restricted error description")
        case .failureReadingCalendarItem:
            return NSLocalizedString("Failed to read a calendar item", comment: "failed reading calendar item error description")
        case .failedReadingReminders:
            return NSLocalizedString("Failed to read reminders", comment: "failed reading reminders error description")
        case .remindersHasNotDueDate:
            return NSLocalizedString("A reminder has no due date", comment: "reminder has no due datea error description")
        case .unknown:
            return NSLocalizedString("An unknown error occurred", comment: "unknown error description")
        }
    }
    
}
