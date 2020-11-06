//
//  main.swift
//  LadderLength
//
//  Created by 肖仲文 on 2020/11/5.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class TreeNode {
    let val: String
    var childs: [TreeNode]?
    
    init(_ val: String) {
        self.val = val
    }
}

class Solution {
    
    func canTransform(from:String, to:String) -> Bool {
        
        var iterator1 = from.makeIterator()
        var iterator2 = to.makeIterator()
        var count = 0
        while let c1 = iterator1.next(), let c2 = iterator2.next() {
            if c1 != c2 {
                count += 1
            }
        }
        return count == 1
    }
    
    func insertLeaf(_ root: TreeNode, _ leaf: TreeNode) -> Int {
        var queue = [root]
        
        var level = 0
        while queue.count > 0 {
            for node in queue {
                if canTransform(from: leaf.val, to: node.val) {
                    if let _ = node.childs {
                        node.childs?.append(leaf)
                    } else {
                        node.childs = [leaf]
                    }
                    return level + 2
                } else {
                    queue.removeFirst()
                    if let childs = node.childs {
                        queue.append(contentsOf: childs)
                    }
                }
            }
            level += 1
        }
        return 0
    }
    
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        
        if beginWord == endWord {
            return 1
        }
        
        let root = TreeNode.init(beginWord)
        var list = Array.init(wordList)
        var index = 0
        
        while list.count > 0 {
            if index == list.count {
                break
            }
            
            let str = list[index]
            let result = self.insertLeaf(root, TreeNode.init(str))
            if result > 0 {
                list.remove(at: index)
                if str == endWord {
                    return result
                }
                if index == list.count {
                    index = 0
                }
            } else {
                index += 1
            }
        }
        
        return 0;
    }
}

//let s = Solution().ladderLength("hit", "lot", ["hot","dot","dog","lot","log","cog"])
//"hot","dot","dog","lot","log","cog"
let s = Solution().ladderLength("leet", "code", ["lest","leet","lose","code","lode","robe","lost"])

