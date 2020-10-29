//
//  main.swift
//  BalanceBinaryTree
//
//  Created by 肖仲文 on 2020/10/29.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init() {
        self.val = 0;
        self.left = nil;
        self.right = nil
    }
    
    convenience init(val: Int) {
        self.init()
        self.val = val
    }
    
    convenience init(val: Int, left: TreeNode?, right: TreeNode?) {
        self.init()
        self.val = val
        self.left = left
        self.right = right
    }
}

class Solution {
    
    func max(_ a: Int, _ b: Int) -> Int {
        return (a > b) ? a: b;
    }
    
    func isBlance(root: TreeNode?) -> Bool {
        let result = height(root: root);
        return result >= 0
    }
    
    func height(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        
        // 获取每一个结点左右子树的高度
        let leftHeight = height(root: root?.left)
        let rightHeight = height(root: root?.right)
        
        // 如果高度差大于1, 表示不平衡
        // leftHeight == -1 || rightHeight == -1 用于剪枝, 终止递归
        if leftHeight == -1 || 
            rightHeight == -1 ||
            abs(leftHeight - rightHeight) > 1 {
            return -1;
        }
        return max(leftHeight, rightHeight) + 1
    }
}

