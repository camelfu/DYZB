//
//  PageContentView.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/8.
//

import UIKit

private let ContentCellId = "ContentCellId"

class PageContentView: UIView {

    fileprivate var startOffsetX: CGFloat = 0;
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellId)
        return collectionView
    }()
    
    fileprivate var childVCs: [UIViewController]
    fileprivate weak var parentVC: UIViewController?
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController?) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContentView {
    fileprivate func setUI() {
        for childVC in childVCs {
            parentVC?.addChild(childVC)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellId, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
}

//MRAK: -UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let contentOffsetX: CGFloat = scrollView.contentOffset.x
        let scrollWidth: CGFloat = scrollView.frame.width
        
        //判断左滑.右滑
        if contentOffsetX > startOffsetX {
            //左滑
            progress = contentOffsetX / scrollWidth - floor(contentOffsetX / scrollWidth)
            sourceIndex = Int(contentOffsetX / scrollWidth)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            //完全滑过去
            if contentOffsetX - startOffsetX == scrollWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            //右滑
            progress = 1 - (contentOffsetX / scrollWidth - floor(contentOffsetX / scrollWidth))
            targetIndex = Int(contentOffsetX / scrollWidth)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
        }
        
        print("progress:\(progress)  sourceIndex:\(sourceIndex)  target:\(targetIndex)")
    }
}

extension PageContentView {
    func setCurrentIndex(currentIndex: Int)  {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
