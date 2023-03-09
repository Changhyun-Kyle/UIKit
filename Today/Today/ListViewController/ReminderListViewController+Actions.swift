//
//  ReminderListViewController+Actions.swift
//  Today
//
//  Created by 강창현 on 2023/03/08.
//

import UIKit

// MARK: - doneButton tap 시 작동
extension ReminderListViewController {
    @objc func didPressDoneButton(_ sender: ReminderDoneButton) {
        guard let id = sender.id else { return }
        completeReminder(withId: id)
    }
}
