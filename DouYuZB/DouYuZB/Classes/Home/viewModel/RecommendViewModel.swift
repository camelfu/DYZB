//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/15.
//

import UIKit

class RecommendViewModel {
    
}

extension RecommendViewModel {
    func reqeustData() {
        
        
        //请求后面游戏部分数据
        NetWorkTools.reqeustData(.GET, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", params: ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTimeSamp()]) { (result) in
            print(result)
        }
    }
}

