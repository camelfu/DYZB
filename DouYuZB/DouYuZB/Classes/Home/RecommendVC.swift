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
        recommendVM.reqeustData {
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension RecommendVC: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            guard let array: [recommendModel] = recommendVM.anchorGroups[section] as? [recommendModel] else { return 0}
            return array.count
        }else if section == 1 {
            guard let array: [PrettyModel] = recommendVM.anchorGroups[section] as? [PrettyModel] else {return 0}
            return array.count
        }
        
        guard let anchorGroup: AnchorGroup = recommendVM.anchorGroups[section] as? AnchorGroup else {return 0}
        return anchorGroup.room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellId, for: indexPath) as! CollectionViewPrettyCell
            if let array: [PrettyModel] = recommendVM.anchorGroups[1] as? [PrettyModel] {
                let prettyModel = array[indexPath.row]
                prettyCell.loadPrettyData(prettyModel: prettyModel)
            }
            return prettyCell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath) as! CollectionViewNormalCell
            if indexPath.section == 0 {
                if let array: [recommendModel] = recommendVM.anchorGroups[0] as? [recommendModel] {
                    let recommendModel = array[indexPath.row]
                    cell.loadDataWithModel(recommendModel: recommendModel)
                }
            }else{
                if let anchorGroup: AnchorGroup = recommendVM.anchorGroups[indexPath.section] as? AnchorGroup {
                    let roomModel = anchorGroup.room_list[indexPath.row]
                    cell.loadDataWithRoomModel(roomModel: roomModel)
                }
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewId, for: indexPath) as! CollectionHeaderView
        if indexPath.section == 0 {
            headerView.loadHeaderData(title: "推荐", iconStr: "home_header_hot")
        }else if indexPath.section == 1 {
            headerView.loadHeaderData(title: "颜值", iconStr: "home_header_phone")
        }else {
            if let anchorGroup: AnchorGroup = recommendVM.anchorGroups[indexPath.section] as? AnchorGroup {
                print("tagName:\(anchorGroup.tag_name), icon:\(anchorGroup.icon_url)")
                headerView.loadHeaderData(title: anchorGroup.tag_name, iconStr: anchorGroup.icon_url)
            }
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}
