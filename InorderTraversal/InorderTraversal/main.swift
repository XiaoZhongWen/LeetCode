//
//  main.swift
//  InorderTraversal
//
//  Created by 肖仲文 on 2020/10/30.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
         self.right = right
     }
}

class Solution {
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        
        var sequence = [Int]()
        
        if root == nil {
            return sequence
        }
        var stack = [TreeNode]()
        
        stack.append(root!)
        while stack.count > 0 {
            
            var lastNode = stack.last!
            // 循环将左子树结点入栈
            while let left = lastNode.left {
                stack.append(left)
                lastNode = left
            }
            
            // 访问结点
            lastNode = stack.removeLast()
            sequence.append(lastNode.val)
            
            if let right = lastNode.right {
                // 如果右子树结点存在, 则入栈
                stack.append(right)
            } else {
                while stack.count > 0 {
                    // 右子树结点不存在, 则依次pop栈中元素
                    lastNode = stack.removeLast()
                    sequence.append(lastNode.val)
                    if let right = lastNode.right {
                        // 如果右子树结点存在, 则入栈并退出循环
                        stack.append(right)
                        break
                    }
                }
            }
        }
        
        return sequence
    }
    
    func inorderTraversal_1(_ root: TreeNode?) -> [Int] {
        var sequence = [Int]()
        if root == nil {
            return sequence
        }
        
        var stack = [TreeNode]()
        
        var r = root
        
        while r != nil || !stack.isEmpty {
            while let node = r {
                stack.append(node)
                r = r?.left
            }
            
            let last = stack.removeLast()
            sequence.append(last.val)
            r = last.right
        }
        
        return sequence
    }
}

let root = TreeNode.init(1)
let right_1 = TreeNode.init(2)
let left_2 = TreeNode.init(3)

root.right = right_1
right_1.left = left_2
let s = Solution.init()
let sequence = s.inorderTraversal_1(root)
print(sequence)
