//
//  main.swift
//  BSTIterator
//
//  Created by 肖仲文 on 2020/12/14.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

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

class BSTIterator {
    
    var stack: [TreeNode]
    var cur: TreeNode?

    init(_ root: TreeNode?) {
        stack = []
        cur = root
    }
    
    func next() -> Int {
        while let node = cur {
            stack.append(node)
            cur = cur?.left
        }
        let last = stack.popLast()
        cur = last?.right
        return last?.val ?? 0
    }
    
    func hasNext() -> Bool {
        return !stack.isEmpty || cur != nil
    }
}

let root = TreeNode.init().create([6,4,10,2,5,8,12])
let iterator = BSTIterator.init(root)
while (iterator.hasNext()) {
    print(iterator.next())
}

