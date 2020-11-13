//
//  main.swift
//  generateTrees
//
//  Created by 肖仲文 on 2020/11/10.
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
    func generateTrees(_ n: Int) -> [TreeNode?] {
        
        let s = generateTrees(start: 1, end: n)
        
        return s
    }
    
    func generateTrees(start: Int, end: Int) -> [TreeNode?] {
        var s: [TreeNode?] = Array.init()
        
        if start > end {
            return [nil]
        }
        
        if start == end {
            return [TreeNode.init(val: start)]
        }
        
        for index in start...end {
            // 1. index作为根节点
            // 2. 左子树集合
            let lefts = generateTrees(start: start, end: index - 1)
            // 3. 右子树集合
            let rights = generateTrees(start: index + 1, end: end)
            
            // 笛卡尔积
            for left in lefts {
                for right in rights {
                    let r = TreeNode.init(val: index)
                    r.left = left
                    r.right = right
                    s.append(r)
                }
            }
        }
        
        return s
    }
}

let s = Solution.init()
let trees = s.generateTrees(0)
print(trees)

