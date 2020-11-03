//
//  main.swift
//  ZigzagLevelOrder
//
//  Created by 肖仲文 on 2020/11/3.
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
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let r = root else {
            return [[Int]]()
        }
        
        // 哨兵
        let sentinel = TreeNode.init(val: Int.min)
        
        // 保存每一层的节点值集合
        var lists = [[Int]]()
        // 节点队列, 用于辅助层序遍历二叉树
        var nodeQueue = [TreeNode]()
        nodeQueue.append(r)
        nodeQueue.append(sentinel)
        // 树中一层的节点值集合
        var list = [Int]()
        
        // 向list中插入值的方式
        // true 表示按FIFO方式插入, false 表示按FILO方式插入
        var leftToRight = true
        while nodeQueue.count > 0 {
            // 移除队首节点
            let cur = nodeQueue.removeFirst()
            // 当队首节点是哨兵时, 表示开始遍历到树的下一层节点
            if cur.val == Int.min {
                // 下一层
                if nodeQueue.count > 0 {
                    // 当队列不为空时, 添加哨兵
                    nodeQueue.append(sentinel)
                }
                // 将当前层的节点值集合保存到lists中
                lists.append(list)
                // 移除list中的元素, 准备保存下一层的元素
                list.removeAll()
                // 每到下一层, 调整插值的方式
                leftToRight = !leftToRight
            } else {
                if leftToRight {
                    // 表示按FIFO方式插入
                    list.append(cur.val)
                } else {
                    // 表示按FILO方式插入
                    list.insert(cur.val, at: 0)
                }
                
                // 将左子树添加到队列
                if let left = cur.left {
                    nodeQueue.append(left)
                }
                // 将右子树添加到队列
                if let right = cur.right {
                    nodeQueue.append(right)
                }
            }
        }
        
        return lists
    }
}

let root = TreeNode.init();
var r = root.create([3,9,20,0,0,15,7])

let s = Solution()
s.zigzagLevelOrder(r)

