//
//  main.swift
//  PartitionLabels
//
//  Created by 肖仲文 on 2020/7/30.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class Solution {
    func partitionLabels(_ S: String) -> [Int] {
        var map:[Character:Int] = Dictionary.init();
        var cur = 0;
        // 1. 记录每个字符在字符串S中最后出现的位置
        while cur < S.count {
            let index = S.index(S.startIndex, offsetBy: cur);
            let c = S[index];
            map[c] = cur;
            cur += 1;
        }
        
        var partitions:[Int] = Array.init();
        var start = 0;
        var end = 0;
        var index = S.startIndex;
        while start < S.count {
            // 获取当前字符在字符串S中最后出现的位置序号
            index = S.index(S.startIndex, offsetBy: start);
            let c = S[index];
            end = (map[c])!;
            
            // 获取区段
            var i = start + 1;
            while i < end {
                index = S.index(S.startIndex, offsetBy: i);
                let c = S[index];
                if let e = map[c] {
                    if e > end {
                        end = e;
                    }
                } else {
                    break;
                }
                i += 1;
            }
            partitions.append(end - start + 1);
            start = end + 1;
        }
        return partitions;
    }
}
//ababcbacadefegdehijhklij
print(Solution().partitionLabels("aaaababc"));

