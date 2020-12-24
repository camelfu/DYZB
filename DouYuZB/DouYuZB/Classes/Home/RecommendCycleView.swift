//
//  RecommendCycleView.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/23.
//

import UIKit

fileprivate let kCollectionCellId = "kCollectionCellId"

class RecommendCycleView: UIView {
    var cycleData: [[String : NSObject]]? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cycleData?.count ?? 0
        }
    }
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RecommendCycleCell.self, forCellWithReuseIdentifier: kCollectionCellId)
        return collectionView
    }()

    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: self.frame.size.width - 10 - 80, y: self.frame.size.height - 5 - 20, width: 80, height: 20))
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = .orange
        pageControl.numberOfPages = 0
//        pageControl.backgroundColor = .red
        return pageControl
    }()
    
    override init(frame: CGRect) {
        cycleData = [[String : NSObject]]()
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RecommendCycleView {
    fileprivate func loadUI() {
        self .addSubview(collectionView)
        self.addSubview(pageControl)
    }
}

extension RecommendCycleView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleData!.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellId, for: indexPath) as! RecommendCycleCell
        let dic = cycleData?[indexPath.item]
        cell.loadCycleData(dic: dic)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
