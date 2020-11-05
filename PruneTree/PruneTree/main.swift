//
//  main.swift
//  PruneTree
//
//  Created by 肖仲文 on 2020/11/5.
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
    
    func create(_ nums:[Int]?) -> TreeNode? {
        guard let nodeValues = nums else {
            return nil
        }
        guard nodeValues.count > 0 else {
            return nil
        }
        
        var roots = [TreeNode]()
        
        // 1. 创建根结点
        let root = TreeNode.init()
        roots.append(root)
        
        for i in 0..<nodeValues.count {
            if roots.count <= 0 {
                continue;
            }
            let cur = roots.removeFirst()
            if i == 0 {
                root.val = nodeValues[i]
            }
            
            // 2. 左子树结点
            var j = i << 1 + 1
            if j < nodeValues.count && nodeValues[j] != Int.min {
                let left = TreeNode.init(val: nodeValues[j])
                cur.left = left
                roots.append(left)
            }
            
            // 3. 右子树结点
            j = i << 1 + 2
            if j < nodeValues.count && nodeValues[j] != Int.min {
                let right = TreeNode.init(val: nodeValues[j])
                cur.right = right
                roots.append(right)
            }
        }
        
        return root
    }
}

class Solution {
    func pruneTree(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        
        // 剪掉左子树值为0的叶子结点
        let left = pruneTree(root?.left)
        // 剪掉右子树值为0的叶子结点
        let right = pruneTree(root?.right)
        if left == nil ||
            (left?.val == 0 &&
            left?.left == nil &&
            left?.right == nil) {
            root?.left = nil
        }
        if right == nil ||
            (right?.val == 0 &&
            right?.left == nil &&
            right?.right == nil) {
            root?.right = nil
        }
        
        // 当根节点值为0时, 也被剪掉
        if root?.left == nil &&
            root?.right == nil &&
            root?.val == 0 {
            return nil
        }
        
        return root
    }
}

let root = TreeNode.init().create([1, 1, 0])
let s = Solution.init().pruneTree(root)
print(s);

