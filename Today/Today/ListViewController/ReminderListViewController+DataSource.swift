//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by 강창현 on 2023/03/07.
//

import UIKit

// MARK: - 미리 알림 목록에 대한 데이터 소스 역할을 하는 모든 동작이 포함
extension ReminderListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Reminder.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Reminder.ID>
    
    var reminderCompletedValue: String {
        NSLocalizedString("Completed", comment: "Reminder completed value")
    }
    
    var reminderNotCompletedValue: String {
        NSLocalizedString("Not completed", comment: "Reminder not completed value")
    }
    
    // MARK: - reloading 파라미터를 통해 변경된 id 값 전달
    func updateSnapshot(reloading ids: [Reminder.ID] = []) {
        var snapShot = Snapshot()
        // 스냅샷에 단일 섹션 추가
        snapShot.appendSections([0])
        // 아래 코드 리팩토링
        snapShot.appendItems(reminders.map { $0.id })
        // snapShot.appendItems(Reminder.sampleData.map { $0.title })
        /*
        var reminderTitles = [String]()
        for reminder in Reminder.sampleData {
            reminderTitles.append(reminder.title)
        }
        snapShot.appendItems(reminderTitles)
        */
        if !ids.isEmpty {
            snapShot.reloadItems(ids)
        }
        // 스냅샷을 데이터 소스에 적용
        dataSource.apply(snapShot)
    }
    
    // 셀의 내용과 모양을 구성하는 방법 지정
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: Reminder.ID) {
        // let reminder = reminders[indexPath.item]
        let reminder = reminder(withId: id)
        // 셀의 기본 콘텐츠 구성 - 미리 정의된 시스템 스타일로 콘텐츠 구성
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessibilityCustomActions = [doneButtonAccessibilityAction(for: reminder)]
        cell.accessibilityValue = reminder.isComplete ? reminderCompletedValue : reminderNotCompletedValue
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration),
            .disclosureIndicator(displayed: .always)
        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listGroupedCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
    }
    
    func reminder(withId id: Reminder.ID) -> Reminder {
        let index = reminders.indexOfReminder(withId: id)
        return reminders[index]
    }
    
    func updateReminder(_ reminder: Reminder) {
        let index = reminders.indexOfReminder(withId: reminder.id)
        reminders[index] = reminder
    }
    
    // MARK: - 버튼이 눌렸을 때 실행되는 함수
    func completeReminder(withId id: Reminder.ID) {
        var reminder = reminder(withId: id)
        reminder.isComplete.toggle()
        updateReminder(reminder)
        updateSnapshot(reloading: [id])
    }
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func deleteReminder(withId id: Reminder.ID) {
        let index = reminders.indexOfReminder(withId: id)
        reminders.remove(at: index)
    }
    
    private func doneButtonAccessibilityAction(for reminder: Reminder) -> UIAccessibilityCustomAction {
        let name = NSLocalizedString("Toggle complete", comment: "Reminder done button accessibility label")
        // ???: - [weak self]와 @escaping closure
        let action = UIAccessibilityCustomAction(name: name) { [weak self] action in
            self?.completeReminder(withId: reminder.id)
            return true
        }
        return action
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration {
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = ReminderDoneButton()
        button.addTarget(self, action: #selector(didPressDoneButton(_:)), for: .touchUpInside)
        button.id = reminder.id
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
}
