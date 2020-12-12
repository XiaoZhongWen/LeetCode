//
//  main.swift
//  lowestCommonAncestor
//
//  Created by 肖仲文 on 2020/12/12.
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
    // p结点的深搜遍历路径
    var dfsPathOfP: [TreeNode]?
    // q结点的深搜遍历路径
    var dfsPathOfQ: [TreeNode]?
    
    func dfs(_ root: TreeNode?, _ p: TreeNode, _ q: TreeNode, _ path: [TreeNode]) {
        guard let _root = root else {
            return
        }
        
        let count1 = dfsPathOfP?.count ?? 0
        let count2 = dfsPathOfQ?.count ?? 0
        if count1 > 0 && count2 > 0 {
            return
        }
        
        let curPath = path + [_root]
        if _root.val == p.val {
            self.dfsPathOfP = curPath
        }
        if _root.val == q.val {
            self.dfsPathOfQ = curPath
        }
        dfs(root?.left, p, q, curPath)
        dfs(root?.right, p, q, curPath)
    }
    
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        guard let _root = root else {
            return nil
        }
        guard let _p = p else {
            return nil
        }
        guard let _q = q else {
            return nil
        }
        
        dfs(_root, _p, _q, []);
        
        guard let _dfsPathOfP = self.dfsPathOfP else {
            return nil
        }
        
        guard let _dfsPathOfQ = self.dfsPathOfQ else {
            return nil
        }
        
        var map: [Int:TreeNode] = [:];
        var treeNode: TreeNode?
        for item in _dfsPathOfP + _dfsPathOfQ {
            if map[item.val] == nil {
                map[item.val] = item
            } else {
                treeNode = item
            }
        }
        return treeNode
    }
}

let root = TreeNode.init().create([3,5,1,6,2,0,8,0,0,7,4])
let treeNode = Solution.init().lowestCommonAncestor(root, TreeNode.init(val: 5), TreeNode.init(val: 4))
print(treeNode?.val)

