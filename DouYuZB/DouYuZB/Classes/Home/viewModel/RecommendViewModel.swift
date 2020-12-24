//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/15.
//

import UIKit

class RecommendViewModel {
    lazy var anchorGroups: [Any] = [Any]()
    fileprivate lazy var conmmendArray: [recommendModel] = [recommendModel]()
    fileprivate lazy var prettyArray: [PrettyModel] = [PrettyModel]()
    lazy var cycleList: [[String : NSObject]] = [[String : NSObject]]()
}

extension RecommendViewModel {
    func reqeustData(_ callBack:@escaping () -> ()) {
        let params = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTimeSamp()]
        //http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1608075825
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetWorkTools.reqeustData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", params: ["time" : Date.getCurrentTimeSamp()]) { (resultData) in
            guard let dataList = resultData["data"] as? [[String : NSObject]] else {return}
            for dic in dataList {
                guard let model = JSONDecoder.jsonDecoder(recommendModel.self, fromAny: dic) else {return}
                self.conmmendArray.append(model)
//                print("推荐人数:\(model.online)")
            }
            dispatchGroup.leave()
        }
        
        //请求颜值数据
        //http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1608075825
        dispatchGroup.enter()
        NetWorkTools.reqeustData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", params: params) { (resultData) in
            guard let dataList = resultData["data"] as? [[String : NSObject]] else {return}
//            self.prettyGroup.tag_name = "颜值"
//            self.prettyGroup.icon_url = "home_header_phone"
            for dic in dataList {
                guard let pretty = JSONDecoder.jsonDecoder(PrettyModel.self, fromAny: dic) else {return}
                self.prettyArray.append(pretty)
//                print("在线人数:\(pretty.online)")
//                self.prettyGroup.room_list.append(anchorModel)
            }
            dispatchGroup.leave()
        }
        
        //请求后面游戏部分数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1608075825
        dispatchGroup.enter()
        NetWorkTools.reqeustData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: params) { (dataDic) in
            guard let dataList = dataDic["data"] as? [[String : NSObject]] else {return}
            for dic: [String : NSObject] in dataList {
                guard let group: AnchorGroup = JSONDecoder.jsonDecoder(AnchorGroup.self, fromAny: dic) else{return}
                self.anchorGroups.append(group)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main){
            self.anchorGroups.insert(self.prettyArray, at: 0)
            self.anchorGroups.insert(self.conmmendArray, at: 0)
            callBack()
        }
    }
    func requestCycleData(_ callBack:@escaping () -> ()) {
        //http://www.douyutv.com/api/v1/slide/6?version=2.300
        NetWorkTools.reqeustData(.GET, urlString: "http://www.douyutv.com/api/v1/slide/6", params: ["version" : "2.300"]) { (resultData) in
            guard let dataList = resultData["data"] as? [[String : NSObject]] else {return}
            self.cycleList = dataList
            callBack()
        }
    }
    
}

