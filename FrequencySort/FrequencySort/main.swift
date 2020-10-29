//
//  main.swift
//  FrequencySort
//
//  Created by 肖仲文 on 2020/7/23.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class Solution {
    func frequencySort(_ s: String) -> String {
        var index = s.startIndex;
        var map = [Character:Int]();
        while index != s.endIndex {
            let c = s[index];
            if let frequence = map[c] {
                map[c] = frequence + 1;
            } else {
                map[c] = 1;
            }
            index = s.index(after: index);
        }
        
        var buckets = Array.init(repeating: [Character](), count: (s.count + 1));
        for key in map.keys {
            if let frequence = map[key] {
                buckets[frequence].append(contentsOf: Array.init(repeating: key, count: frequence));
            }
        }
        
        var charSet = [Character]();
        buckets.reverse();
        for bucket in buckets {
            if bucket.count > 0 {
                charSet.append(contentsOf: bucket);
            }
        }
        
        let str = String.init(charSet);
        
        return str;
    }
}

print(Solution().frequencySort("cccaaa"));

