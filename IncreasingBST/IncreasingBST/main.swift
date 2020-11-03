//
//  main.swift
//  IncreasingBST
//
//  Created by 肖仲文 on 2020/11/2.
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
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        if root == nil {
            return nil
        }
        var cur = TreeNode.init(0)
        let newRoot = cur
        inorder(root, &cur)
        return newRoot.right
    }
    
    func inorder(_ node: TreeNode?, _ curNode: inout TreeNode) {
        if node == nil {
            return
        }
        inorder(node?.left, &curNode)
        node?.left = nil
        curNode.right = node
        curNode = node!;
        inorder(node?.right, &curNode)
    }
}

