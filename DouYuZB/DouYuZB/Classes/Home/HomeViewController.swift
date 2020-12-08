//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/7.
//

import UIKit

private let kTitleViewH : CGFloat = 40
class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let frame  = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContentView: PageContentView = {
        let height: CGFloat = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: height)
        var childVCs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVCs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: frame, childVCs: childVCs, parentVC: self)
        return pageContentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}

//MARK: - setUI
extension HomeViewController{
    private func setupUI(){
        setNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setNavigationBar(){
//        let btn = UIButton()
//        btn.setImage(UIImage(named: "logo"), for: .normal)
//        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", hilightImageName: "", size: CGSize.zero)
        
        let size = CGSize(width: 40, height: 40)
   
//        let historyItem = UIBarButtonItem.creatBarButtonItem(imageName: "image_my_history", hilightImageName: "Image_my_history_click", size: size)
//        let searchItem = UIBarButtonItem.creatBarButtonItem(imageName: "btn_search", hilightImageName: "btn_search_clicked", size: size)
//        let scanItem = UIBarButtonItem.creatBarButtonItem(imageName: "Image_scan", hilightImageName: "Image_scan_click", size: size)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hilightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hilightImageName: "btn_search_clicked", size: size)
        let scanItem = UIBarButtonItem(imageName: "Image_scan", hilightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,scanItem]
    }
}

//MARK: - PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func PageTitleViewClick(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
