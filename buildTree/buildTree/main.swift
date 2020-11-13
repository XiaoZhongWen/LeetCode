//
//  main.swift
//  buildTree
//
//  Created by 肖仲文 on 2020/11/13.
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
    
    func buildTree(preorder: [Int], inorder: [Int]) -> TreeNode? {
        if preorder.count == 0 || inorder.count == 0 {
            return nil
        }
        
        if preorder.count == 1 && inorder.count == 1 {
            return TreeNode.init(val: preorder[0])
        }
        
        if let rValue = preorder.first {
            let root = TreeNode.init(val: rValue)
            var rIndex = 0
            for value in inorder {
                if value == rValue {
                    break
                }
                rIndex += 1
            }
            var lpreorder:[Int] = [];
            if rIndex >= 1 {
                lpreorder = Array.init(preorder[1...rIndex])
            }
            root.left = buildTree(preorder: lpreorder, inorder: Array.init(inorder[0..<rIndex]));
            var rpreorder:[Int] = []
            var rinorder:[Int] = []
            if rIndex + 1 < preorder.count {
                rpreorder = Array.init(preorder[rIndex + 1..<preorder.count])
                rinorder = Array.init(inorder[rIndex + 1..<inorder.count])
            }
            root.right = buildTree(preorder: rpreorder, inorder: rinorder);
            
            return root
        } else {
            return nil
        }
    }
    
    func buildTree(inorder: [Int], postorder: [Int]) -> TreeNode? {
        
        if inorder.count == 0 || postorder.count == 0 {
            return nil
        }
        
        if inorder.count == 1 && postorder.count == 1 {
            return TreeNode.init(val: inorder[0])
        }
        
        var rIndex = 0
        let rValue = postorder.last!
        for index in 0..<inorder.count {
            if inorder[index] == rValue {
                break
            }
            rIndex += 1
        }
        
        let root = TreeNode.init(val: rValue)
        
        var lInorder:[Int] = []
        var lpostorder:[Int] = []
        if rIndex > 0 {
            lInorder = Array.init(inorder[0..<rIndex])
            lpostorder = Array.init(postorder[0..<rIndex])
        }
        root.left = buildTree(inorder: lInorder, postorder: lpostorder)
        
        var rInorder:[Int] = []
        var rpostorder:[Int] = []
        if rIndex < inorder.count {
            rInorder = Array.init(inorder[rIndex + 1..<inorder.count])
            rpostorder = Array.init(postorder[rIndex..<postorder.count - 1])
        }
        root.right = buildTree(inorder: rInorder, postorder: rpostorder)
        
        return root
    }
}

let s = Solution.init()
//let r = s.buildTree(preorder: [3,9,20,15,7], inorder: [9,3,15,20,7])
let r = s.buildTree(inorder: [2,1,3], postorder: [2,3,1])
print(r)

