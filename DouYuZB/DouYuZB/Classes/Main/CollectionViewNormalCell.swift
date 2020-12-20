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
        onlineBtn .setTitle("\(recommendModel.online)", for: .normal)
    }
    
    func loadDataWithRoomModel(roomModel: AnchorRoomModel) {
        roomName.text = roomModel.room_name
        nickName.text = roomModel.nickname
        onlineBtn .setTitle(roomModel.online, for: .normal)
    }
}
