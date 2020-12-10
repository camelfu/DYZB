//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/7.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func PageTitleViewClick(_ titleView: PageTitleView, selectedIndex index: Int)
}

private let kScrollLineH : CGFloat = 4
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    weak var delegate: PageTitleViewDelegate?
    
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    fileprivate func setupUI(){
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabels(){
        let kLabelW : CGFloat = frame.width / CGFloat(titles.count)
        let kLabelH : CGFloat = frame.height - kScrollLineH
        let kLabelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let kLabelX : CGFloat = kLabelW * CGFloat(index)
            label.frame = CGRect(x: kLabelX, y: kLabelY, width: kLabelW, height: kLabelH)
            scrollView .addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.gray
        let bottomLineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - bottomLineH, width: frame.width, height: bottomLineH)
        addSubview(bottomLine)
        
        guard let firstLabel = titleLabels.first else{ return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH - 0.5, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView{
    @objc fileprivate func titleLabelClick(_ tap:UITapGestureRecognizer) {
        guard let currentLabel = tap.view as? UILabel else{ return }
        if currentLabel.tag == currentIndex {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        currentIndex = currentLabel.tag
        
        let scrollLineX = scrollLine.frame.width * CGFloat(currentIndex)
        UIView .animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.PageTitleViewClick(self, selectedIndex: currentIndex)
    }
}

extension PageTitleView {
    
}
