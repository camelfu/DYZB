//
//  CollectionViewPrettyCell.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/14.
//

import UIKit
import Kingfisher
class CollectionViewPrettyCell: UICollectionViewCell {
    @IBOutlet weak var locationImgView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var onlineLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CollectionViewPrettyCell {
    func loadPrettyData(prettyModel: PrettyModel) {
        roomName.text = prettyModel.room_name
        cityLabel.text = prettyModel.anchor_city
        let online = getOnlineString(online: prettyModel.online)
        onlineLabel.text = "\(online)在线"
        backImgView.kf.setImage(with: URL.init(string: prettyModel.vertical_src))
    }
    
    fileprivate func getOnlineString(online: Int) -> String {
        if online >= 10000 {
            let f: Float = Float(online) / 10000.0
            let numberFormater = NumberFormatter()
            numberFormater.numberStyle = .decimal
            numberFormater.minimumFractionDigits = 0
            numberFormater.maximumFractionDigits = 1
            
            let onlineStr: String = numberFormater.string(from: NSNumber.init(value: f)) ?? "0"
            return "\(onlineStr)万"
        }
        
        return "\(online)"
    }
}
