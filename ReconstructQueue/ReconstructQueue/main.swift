//
//  main.swift
//  ReconstructQueue
//
//  Created by 肖仲文 on 2020/7/29.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class Solution {
    func reconstructQueue(_ people: [[Int]]) -> [[Int]] {
        var queue:[[Int]] = Array.init(repeating: [], count: people.count);
        
        // 1. 将相同高度的人, 以序号递增的顺序保存在map中
        var map:[Int:[Int]] = Dictionary.init();
        for p in people {
            let h = p.first!;
            let k = p.last!;
            if let array = map[h] {
                var index = 0;
                while index < array.count {
                    if array[index] > k {
                        map[h]?.append(k);
                        break;
                    }
                    index += 1;
                }
                if index == array.count {
                    map[h]?.append(k);
                } else {
                    map[h]?.swapAt(index, array.count);
                }
            } else {
                map[h] = Array.init(repeating: k, count: 1);
            }
        }
        
        // 2. 按高度进行排序
        let array = map.keys.sorted { (a, b) -> Bool in
            return a >= b;
        }
        
        // 3. 重建队列
        // 由高到低, 按序号(k)入队, 当身高(h)矮的人的序号被身高高的人占用时, 则依次插队
        for h in array {
            let sequence = map[h] ?? [];
            if sequence.count == 0 {
                continue;
            }
            var index = 0;
            while index < sequence.count {
                let k = sequence[index];
                if queue[k].count == 0 {
                    queue[k].append(h);
                    queue[k].append(k);
                } else {
                    queue.insert([h, k], at: k);
                    queue.removeLast();
                }
                index += 1;
            }
        }
        
        return queue
    }
}

Solution().reconstructQueue([[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]);

