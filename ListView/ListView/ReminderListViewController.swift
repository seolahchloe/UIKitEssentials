//
//  ViewController.swift
//  ListView
//
//  Created by Chloe Chung on 2023/07/21.
//

import UIKit


class ReminderListViewController: UICollectionViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>


    var dataSource: DataSource!


    override func viewDidLoad() {
        super.viewDidLoad()


        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        /// 새로운 셀 등록 생성
        /// - 셀의 내용과 모양을 구성하는 방법을 지정합니다.
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            // item에 해당하는 알림을 가져오기
            let reminder = Reminder.sampleData[indexPath.item]
            // 셀의 기본 콘텐츠 구성을 가져오기
            /// - defaultContentConfiguration으로 미리 정의된 시스템 스타일로 콘텐츠 구성을 생성
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            cell.contentConfiguration = contentConfiguration
            
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
//        var reminderTitles = [String]()
//        var reminder in Reminder.sampleData {
//            reminderTitles.append(reminder.title)
//        }
//        snapshot.appendItem(reminderTitles)
        snapshot.appendItems(Reminder.sampleData.map { $0.title })
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
    
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        //
        var listConfiguartion = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguartion.showsSeparators = false
        listConfiguartion.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguartion)
    }

}



