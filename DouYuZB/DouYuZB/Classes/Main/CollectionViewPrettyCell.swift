//
//  CollectionViewPrettyCell.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/14.
//

import UIKit

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
        onlineLabel.text = "\(prettyModel.online)"
    }
}
