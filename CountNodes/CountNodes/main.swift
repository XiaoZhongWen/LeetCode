//
//  main.swift
//  CountNodes
//
//  Created by 肖仲文 on 2020/11/4.
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
    
    func height(for root: TreeNode?) -> Int {
        var level: Int = 0
        var node = root
        while node != nil {
            level = level + 1
            node = node?.left
        }
        return level
    }
    
    func countNodes(_ root: TreeNode?) -> Int {
        
        if root == nil {
            return 0
        }
        
        // 左子树高度
        let left = height(for: root?.left)
        // 右子树高度
        let right = height(for: root?.right)
        
        if left == right {
            // 左右子树高度相等, 说明左子树是满二叉树
            return countNodes(root?.right) + 1 << left
        } else {
            // 左右子树高度不相等, 说明右子树是满二叉树
            return countNodes(root?.left) + 1 << right
        }
    }
}

