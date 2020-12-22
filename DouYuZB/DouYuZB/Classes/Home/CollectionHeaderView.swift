//
//  CollectionHeaderView.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/14.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
}

extension CollectionHeaderView {
    func loadHeaderData(title: String, iconStr: String) {
        titleLabel.text = title
        if iconStr.contains("http") {
            iconImgView.kf.setImage(with: URL.init(string: iconStr))
        }else{
            iconImgView.image = UIImage.init(named: iconStr)
        }
    }
}
