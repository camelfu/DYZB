//
//  CollectionViewNormalCell.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/14.
//

import UIKit

class CollectionViewNormalCell: UICollectionViewCell {

    @IBOutlet weak var backImgView: UIImageView!
    @IBOutlet weak var iconImgView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var nickName: UILabel!
}

extension CollectionViewNormalCell {
    func loadDataWithModel(recommendModel: recommendModel) {
        roomName.text = recommendModel.room_name
        nickName.text = recommendModel.nickname
        let online = getOnlineString(online: recommendModel.online)
        onlineBtn .setTitle(online, for: .normal)
        backImgView.kf.setImage(with: URL.init(string: recommendModel.vertical_src))
    }
    
    func loadDataWithRoomModel(roomModel: AnchorRoomModel) {
        roomName.text = roomModel.room_name
        nickName.text = roomModel.nickname
        let online = getOnlineString(online: Int(roomModel.online.description)!)
        onlineBtn .setTitle(online, for: .normal)
        backImgView.kf.setImage(with: URL.init(string: roomModel.vertical_src))
    }
}

extension CollectionViewNormalCell {
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
