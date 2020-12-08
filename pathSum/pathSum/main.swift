//
//  main.swift
//  pathSum
//
//  Created by 肖仲文 on 2020/12/4.
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
    func dfs(_ root: TreeNode?, _ path: [Int], _ sum: Int, _ result: inout [[Int]]) {
        guard let r = root else {
            return
        }
        var curPath: [Int] = path + [r.val]
        curPath[0] = curPath[0] - r.val
        if curPath[0] == 0 &&
            r.left == nil &&
            r.right == nil {
            result.append(Array.init(curPath[1...]));
        }
        dfs(r.left, curPath, sum, &result)
        dfs(r.right, curPath, sum, &result)
    }
    
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var list: [[Int]] = []
        dfs(root, [sum], sum, &list)
        return list;
    }
}

let root = TreeNode().create([-2,0,-3])
print(Solution().pathSum(root, -5))

