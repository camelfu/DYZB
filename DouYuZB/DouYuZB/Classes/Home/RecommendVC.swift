//
//  RecommendVC.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/13.
//

import UIKit

fileprivate let kItemMargin: CGFloat = 10
fileprivate let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kNormalItemH = kNormalItemW * 3 / 4
fileprivate let kHeadViewH: CGFloat = 50

fileprivate let kNormalCellId: String = "kNormalCellId"
fileprivate let kHeaderViewId: String = "kNormalCellId"

class RecommendVC: UIViewController {
    //懒加载
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeadViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
        setupUI()
    }

}

extension RecommendVC {
    fileprivate func setupUI() {
        self.view.addSubview(collectionView)
    }
}
//MARK: - UICollectionViewDataSource
extension RecommendVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath)
        headerView.backgroundColor = UIColor.orange
        return headerView
    }
    
}
