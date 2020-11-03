//
//  main.swift
//  CountPairs
//
//  Created by 肖仲文 on 2020/11/2.
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
            if j < nodeValues.count && nodeValues[j] != 0 {
                let left = TreeNode.init(val: nodeValues[j])
                cur.left = left
                roots.append(left)
            }
            
            // 3. 右子树结点
            j = i << 1 + 2
            if j < nodeValues.count && nodeValues[j] != 0 {
                let right = TreeNode.init(val: nodeValues[j])
                cur.right = right
                roots.append(right)
            }
        }
        
        return root
    }
}

class Solution {
    
    var ans: Int = 0
    
    func countPairs(_ root: TreeNode?, _ distance: Int) -> Int {
        dfs(root, distance)
        return ans
    }
    
    func dfs(_ root: TreeNode?, _ distance: Int) -> [Int] {
        
        guard let curNode = root else {
            return []
        }
        if curNode.left == nil && curNode.right == nil {
            return [1]
        }
        
        // 结点curNode的左子树叶子节点到curNode的距离集合
        var l = dfs(curNode.left, distance)
        // 结点curNode的右子树叶子节点到curNode的距离集合
        var r = dfs(curNode.right, distance)
        
        // 遍历两个集合, 统计距离和大于distance的数量
        for i in l {
            for j in r {
                if i + j <= distance {
                    ans = ans + 1
                }
            }
        }
        
        // 左子树距离集合各元素值加1
        l = l.map { (item) -> Int in
            let result = item + 1
            return result
        }
        // 右子树距离集合各元素值加1
        r = r.map { (item) -> Int in
            let result = item + 1
            return result
        }
        
        // 合并两个集合
        var s = [Int]()
        s.append(contentsOf: l)
        s.append(contentsOf: r)
        return s
    }
}

var root = TreeNode.init()
let s = Solution()
let count = s.countPairs(root.create([1,2,3,4,5,6,7]), 4)
print(count)

