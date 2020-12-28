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
            let pageSize:CGSize = pageControl.size(forNumberOfPages: cycleData?.count ?? 0)
            pageControl.frame = CGRect(x: self.frame.size.width - 10 - pageSize.width, y: self.frame.size.height - pageSize.height + 3, width: pageSize.width, height: pageSize.height)
            //滚动到中间位置
            let indexPath = IndexPath(item: (cycleData?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //添加定时器
            removeTimer()
            addCycleTimer()
        }
    }
    
    fileprivate var cycleTimer: Timer?
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
        let pageControl = UIPageControl(frame: CGRect(x: self.frame.size.width/2 - 10, y: self.frame.size.height - 20, width: self.frame.size.width/2, height: 20))
        pageControl.pageIndicatorTintColor = .red
        pageControl.currentPageIndicatorTintColor = .blue
        
//        pageControl.numberOfPages = 0
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
        return (cycleData?.count ?? 0) * 10000;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionCellId, for: indexPath) as! RecommendCycleCell
        let dic = cycleData?[indexPath.item % cycleData!.count]
        cell.loadCycleData(dic: dic)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleData?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(selectToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .common)
    }
    
    @objc fileprivate func selectToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = collectionView.bounds.size.width + currentOffsetX
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
    fileprivate func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
}
