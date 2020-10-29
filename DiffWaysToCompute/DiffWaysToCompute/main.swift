//
//  main.swift
//  DiffWaysToCompute
//
//  Created by 肖仲文 on 2020/8/6.
//  Copyright © 2020 肖仲文. All rights reserved.
//

import Foundation

class Solution {
    
    func computerExpression(_ expression:String) -> Int {
        var stack:[Character] = Array.init();
        if let first = expression.first {
            stack.append(first);
            var i = 1;
            while stack.count != 0 && i < expression.count {
                let top = expression[expression.endIndex];
                let index = expression.index(expression.startIndex, offsetBy: i);
                let c = expression[index];
                if c == "+" ||
                   c == "-" ||
                   c == "*" ||
                   c == "(" {
                    stack.append(c);
                } else {
                    if c == ")" {
                        
                    } else {
                        let sign = stack[stack.endIndex];
                        stack.removeLast();
                        switch sign {
                        case "+":
                            let d = stack[stack.endIndex];
                            stack.removeLast();
                            
                            break;
                        case "-":
                            break;
                        case "*":
                            break;
                        default:
                            break;
                        }
                    }
                }
                i += 1;
            }
            
        }
        return 0;
    }
    
    func diffWaysToCompute(_ input: String) -> [Int] {
        if input.count < 0 {
            return [];
        }
        
        if input.count == 1 {
            if let c = input.first, let value = c.wholeNumberValue {
                return [value];
            } else {
                return [];
            }
        }
        
        var expressions:[String] = Array.init();
        var i = 0;
        var j = 1;
        while i < input.count {
            let l = input.index(input.startIndex, offsetBy: i);
            var c = input[l];
            if c == "+" ||
               c == "-" ||
               c == "*" {
                i += 1;
                continue;
            } else {
                j = i + 1;
            }
            while j < input.count {
                let r = input.index(input.startIndex, offsetBy: j);
                c = input[r];
                if c == "+" ||
                   c == "-" ||
                   c == "*"  {
                    var s = String.init(input);
                    s.insert(")", at: r);
                    s.insert("(", at: l);
                    expressions.append(s);
                }
                j += 1;
            }
            if i != j {
                var s = String.init(input);
                s.append(")");
                s.insert("(", at: l);
                expressions.append(s);
            }
            i += 1;
        }
        
        var results:[Int] = Array.init();
        for expression in expressions {
//            results.append(self.computerExpression(expression));
        }
        
        return results;
    }
}

Solution().diffWaysToCompute("12+23+34");

