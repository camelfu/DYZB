//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/16.
//

import UIKit

struct AnchorGroup: Codable {
    ///对应房间信息
    var room_list: [AnchorRoomModel] = [AnchorRoomModel]()
    ///组标题
    var tag_name: String = ""
    ///组图标
    var icon_url: String = "home_header_normal"//默认图标
    
    init() {
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tag_name = try container.decode(String.self, forKey: .tag_name)
        icon_url = try container.decode(String.self, forKey: .icon_url)
        room_list = try container.decode([AnchorRoomModel].self, forKey: .room_list)
    }
}


