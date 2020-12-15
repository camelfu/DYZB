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
fileprivate let kPrettyItemH = kNormalItemW * 4 / 3
fileprivate let kHeadViewH: CGFloat = 50

fileprivate let kNormalCellId: String = "kNormalCellId"
fileprivate let kPrettyCellId: String = "kPrettyCellId"
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
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kHeaderViewId)
        
        return collectionView
    }()
    fileprivate lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setupUI()
        
        requestData()
    }

}

extension RecommendVC {
    fileprivate func setupUI() {
        self.view.addSubview(collectionView)
    }
}

extension RecommendVC {
    fileprivate func requestData() {
        recommendVM.reqeustData()
    }
}

//MARK: - UICollectionViewDataSource
extension RecommendVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
        var cell: UICollectionViewCell!
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath)
  
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
