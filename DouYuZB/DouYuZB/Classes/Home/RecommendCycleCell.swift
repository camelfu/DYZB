//
//  RecommendCycleCell.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/24.
//

import UIKit

class RecommendCycleCell: UICollectionViewCell {
    fileprivate lazy var iconImgView: UIImageView = {
        let iconImgView = UIImageView(frame: self.bounds)
        iconImgView.image = UIImage.init(named: "Img_default")
        return iconImgView
    }()
    
    fileprivate lazy var bottomView: UIView = {
       let bottomView = UIView(frame: CGRect(x: 0, y: self.bounds.size.height - 20, width: self.bounds.size.width, height: 20))
        bottomView.backgroundColor = .darkGray
        return bottomView
    }()
    
    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    override func layoutSubviews() {
        superview?.layoutSubviews()
        self.addSubview(iconImgView)
        self.addSubview(bottomView)
        bottomView.addSubview(label)
        label.frame = CGRect(x: 15, y: 0, width: bottomView.frame.size.width - 30, height: bottomView.frame.size.height)
    }
}

extension RecommendCycleCell {
    func loadCycleData(dic: [String : NSObject]?) {
        if let title = dic?["title"] as? String {
            label.text = title
        }
        if let pic_url = dic?["pic_url"] as? String {
            iconImgView.kf.setImage(with: URL.init(string: pic_url),placeholder: UIImage.init(named: "Img_default"))
        }
    }
}
