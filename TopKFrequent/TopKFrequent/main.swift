//
//  main.swift
//  TopKFrequent
//
//  Created by 肖仲文 on 2020/7/20.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class Solution {
    // 1. bucket
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var map = [Int:Int]();
        for item in nums {
            if let value = map[item] {
                map[item] = value + 1;
            } else {
                map[item] = 1;
            }
        }
        
        var frequenceBuckets = [[Int]?]();
        for key in map.keys {
            guard let frequence = map[key] else {
                break;
            }
            if var list = frequenceBuckets[frequence] {
                list.append(key);
            } else {
                frequenceBuckets.append([key]);
            }
        }
        
        let index = frequenceBuckets.index(before: frequenceBuckets.endIndex);
        while index != frequenceBuckets.index(before: frequenceBuckets.startIndex) {
            let list = frequenceBuckets[index];
        }
        
        return [];
    }
}

