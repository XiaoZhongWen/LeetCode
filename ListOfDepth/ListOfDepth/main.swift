//
//  main.swift
//  ListOfDepth
//
//  Created by 肖仲文 on 2020/10/29.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    
    init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}

class ListNode {
    var val: Int
    var next: ListNode?
    
    init() {
        self.val = 0
        self.next = nil
    }
    
    convenience init(_ val: Int) {
        self.init()
        self.val = val
    }
}

class Solution {
    func listOfDepth(_ root: TreeNode?) -> [ListNode?] {
        var lists = [ListNode]()
        if root == nil {
            return lists
        }
        
        var nodes = [TreeNode]()
        if let rootNode = root {
            nodes.append(rootNode)
        }
        
        while nodes.count > 0 {
            var header: ListNode? = nil;
            var p: ListNode? = nil;
            
            for node in nodes {
                if header == nil {
                    header = ListNode.init(node.val)
                    p = header
                } else {
                    p?.next = ListNode.init(node.val)
                    p = p?.next
                }
                
                if let left = node.left {
                    nodes.append(left)
                }
                if let right = node.right {
                    nodes.append(right)
                }
                nodes.removeFirst()
            }
            
            if let list = header {
                lists.append(list)
            }
        }
        
        return lists;
    }
}

let tree = TreeNode.init(1)
let left_1 = TreeNode.init(2)
let right_1 = TreeNode.init(3)
tree.left = left_1
tree.right = right_1

let left_2 = TreeNode.init(4)
let right_2 = TreeNode.init(5)
let right_2_2 = TreeNode.init(7)
left_1.left = left_2
left_1.right = right_2
right_1.right = right_2_2

let left_3 = TreeNode.init(8)
left_2.left = left_3

let solution = Solution()
let lists = solution.listOfDepth(tree);
print(lists)

