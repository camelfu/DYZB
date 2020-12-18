//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/15.
//

import UIKit

class RecommendViewModel {
    fileprivate lazy var prettyGroup: AnchorGroup =  AnchorGroup()
    fileprivate lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension RecommendViewModel {
    func reqeustData() {
        let params = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTimeSamp()]

        //请求颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1608075825
        NetWorkTools.reqeustData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: params) { (resultData) in
            guard let dataList = resultData["data"] as? [[String : NSObject]] else {return}
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_url = "home_header_phone"
            for dic in dataList {
                guard let anchorModel = JSONDecoder.jsonDecoder(AnchorRoomModel.self, fromAny: dic) else {return}
                self.prettyGroup.room_list.append(anchorModel)
            }
        }
        
        //请求后面游戏部分数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1608075825
        NetWorkTools.reqeustData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: params) { (dataDic) in
            guard let dataList = dataDic["data"] as? [[String : NSObject]] else {return}
            
            for dic: [String : NSObject] in dataList {
                guard let group: AnchorGroup = JSONDecoder.jsonDecoder(AnchorGroup.self, fromAny: dic) else{
                    return
                }
                self.anchorGroups.append(group)
            }
        }
    }
}

