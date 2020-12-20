//
//  PrettyModel.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/19.
//

import UIKit

struct PrettyModel: Codable {
    ///room_id
    var room_id: String = "0"
    /// 房间图片对应的URLString
    var vertical_src: String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical: Int = 0
    /// 房间名称
    var room_name: String = ""
    /// 主播昵称
    var nickname: String = ""
    /// 观看人数
    var online: Int = 0
    /// 所在城市
    var anchor_city: String = ""
    
    init() {
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        room_id = try container.decode(String.self, forKey: .room_id)
        vertical_src = try container.decode(String.self, forKey: .vertical_src)
        isVertical = try container.decode(Int.self, forKey: .isVertical)
        room_name = try container.decode(String.self, forKey: .room_name)
        nickname = try container.decode(String.self, forKey: .nickname)
        online = try container.decode(Int.self, forKey: .online)
        anchor_city = try container.decode(String.self, forKey: .anchor_city)
    }
}

