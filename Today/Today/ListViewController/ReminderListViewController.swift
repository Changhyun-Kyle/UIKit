//
//  ViewController.swift
//  Today
//
//  Created by 강창현 on 2023/03/07.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    // 아래 코드 리팩토링 - extension으로 분리 : ViewController 동작과 DataSorce 동작 분리
    //  typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    //  typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var dataSource: DataSource!
    var reminders: [Reminder] = Reminder.sampleData
    
    // MARK: - 뷰 컨트롤러가 뷰 계층 구조를 메모리에 로드한 후 .viewDidLoad 실행
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        // 셀의 내용과 모양을 구성하는 방법 지정
        // 아래 코드 리팩토링 - extension으로 분리 : ViewController 동작과 DataSorce 동작 분리
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        /*
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            // 셀의 기본 콘텐츠 구성 - 미리 정의된 시스템 스타일로 콘텐츠 구성
            var contentConfigureation = cell.defaultContentConfiguration()
            contentConfigureation.text = reminder.title
            cell.contentConfiguration = contentConfigureation
        }
        */
        // 새 원본 데이터 생성
        dataSource = DataSource(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            // 모든 항목에 대해 새 셀을 만들 수 있지만, 셀을 재사용하면 앱 성능 저하를 방지할 수 있다.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
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
        // 스냅샷을 데이터 소스에 적용
        dataSource.apply(snapShot)
        
        collectionView.dataSource = dataSource
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        //MARK: - UICollectionLayoutListConfiguration: 리스트 레이아웃의 섹션 지정
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        // 구분기호 비활성화
        listConfiguration.showsSeparators = false
        // 배경색 제거
        listConfiguration.backgroundColor = .clear
        // 리스트로 된 새로운 Compositional layout 반환
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

