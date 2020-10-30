//
//  main.swift
//  ConstructMaximumBinaryTree
//
//  Created by 肖仲文 on 2020/10/30.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class Solution {
    func constructMaximumBinaryTree(_ nums: [Int]) -> TreeNode? {
        if nums.count == 0 {
            return nil
        }
        return constructMaximumBinaryTree(0, nums.count - 1, nums)
    }
    
    private func constructMaximumBinaryTree(_ from: Int, _ to: Int, _ nums: [Int]) -> TreeNode? {
        
        if from > to {
            return nil
        }
        
        var maxValue = nums[from]
        var indexForRoot = from
        for index in from...to {
            let value = nums[index]
            if maxValue < value {
                maxValue = value
                indexForRoot = index
            }
        }
        
        let root = TreeNode.init(maxValue)
        if indexForRoot > from {
            let left = constructMaximumBinaryTree(from, indexForRoot - 1, nums)
            root.left = left
        }
        if indexForRoot < to {
            let right = constructMaximumBinaryTree(indexForRoot + 1, to, nums)
            root.right = right
        }
        
        return root;
    }
}

let s = Solution()
let tree = s.constructMaximumBinaryTree([3,2,1,6,0,5])
print(tree)
