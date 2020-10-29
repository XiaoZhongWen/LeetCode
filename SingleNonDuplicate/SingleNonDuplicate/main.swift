//
//  main.swift
//  SingleNonDuplicate
//
//  Created by 肖仲文 on 2020/7/31.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class Solution {
    func singleNonDuplicate(_ nums: [Int]) -> Int {
        if nums.count <= 0 {
            return NSNotFound;
        }
        var l = 0;
        var h = nums.count - 1;
        var m = (l + h) / 2;
        while l != h {
            if m % 2 == 0 && (h - m) % 2 == 0 {
                
            } else if m % 2 == 1 && (h - m) % 2 == 1 {
                
            } else {
                break;
            }
        }
        
        return nums[m];
    }
}

