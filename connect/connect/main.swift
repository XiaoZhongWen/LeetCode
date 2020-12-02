//
//  main.swift
//  connect
//
//  Created by 肖仲文 on 2020/11/16.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

public class Node {
    public var val: Int
    public var left: Node?
    public var right: Node?
    public var next: Node?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
        self.next = nil
    }
    
    init() {
        self.val = 0;
        self.left = nil;
        self.right = nil
    }
    
    convenience init(val: Int) {
        self.init()
        self.val = val
    }
    
    convenience init(val: Int, left: Node?, right: Node?) {
        self.init()
        self.val = val
        self.left = left
        self.right = right
    }
    
    func create(_ nums:[Int]?) -> Node? {
        guard let nodeValues = nums else {
            return nil
        }
        guard nodeValues.count > 0 else {
            return nil
        }
        
        var roots = [Node]()
        
        // 1. 创建根结点
        let root = Node.init()
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
                let left = Node.init(val: nodeValues[j])
                cur.left = left
                roots.append(left)
            }
            
            // 3. 右子树结点
            j = i << 1 + 2
            if j < nodeValues.count && nodeValues[j] != 0 {
                let right = Node.init(val: nodeValues[j])
                cur.right = right
                roots.append(right)
            }
        }
        
        return root
    }
 }

class Solution {
    func connect(_ root: Node?) -> Node? {
        // p 为父节点, 用于给左孩子结点next指针赋值
        var p = root
        p?.next = nil
        // q 记录树每一层的第一个节点
        var q = p?.left
        // 逐层遍历
        while q != nil {
            while p?.left != nil && p?.right != nil {
                // 左孩子结点的next指针指向右孩子结点
                p?.left?.next = p?.right
                // 当父节点的next指针不为空时
                if (p?.next != nil) {
                    // 右孩子节点的next指针指向p.next节点的左孩子
                    p?.right?.next = p?.next?.left
                    p = p?.next;
                } else {
                    // 当父节点的next指针为空时, 表明该节点为该层的最后一个节点
                    p?.right?.next = nil
                    // 开始遍历下一层
                    p = q;
                    q = q?.left
                    break;
                }
            }
        }
        return root
    }
}

let tree = Node.init().create([1,2,3,4,5,6,7])
let s = Solution()
s.connect(tree)

print(tree)
