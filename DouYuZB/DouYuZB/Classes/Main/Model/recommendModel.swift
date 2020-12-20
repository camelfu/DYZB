//
//  recommendModel.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/20.
//

import UIKit

struct recommendModel: Codable {
    var room_id: Int = 0
    var vertical_src: String = ""
    var room_name: String = ""
    var nickname: String = ""
    var online: Int = 0
    var show_status: Int = 0
    
    init() {
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        room_id = try container.decode(Int.self, forKey: .room_id)
        vertical_src = try container.decode(String.self, forKey: .vertical_src)
        room_name = try container.decode(String.self, forKey: .room_name)
        nickname = try container.decode(String.self, forKey: .nickname)
        online = try container.decode(Int.self, forKey: .online)
        show_status = try container.decode(Int.self, forKey: .show_status)
    }
    
    
    
}
