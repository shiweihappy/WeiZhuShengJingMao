//
//  CircleLocation.swift
//  WeiZhuShengJingMao
//
//  Created by lsw on 14-12-26.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

import Foundation

class CircleLocation {
    var row:Int
    var col:Int
    var cost:Int = -100
    var state:Int = 0
    var circleLocationArr:[[CircleLocation]]!
    
    init(row : Int, col:Int) {
        self.row = row
        self.col = col
    }
    
    
    func getLeft() -> CircleLocation? {
        var left : CircleLocation? = nil
        if self.col > 0 {
            left = self.circleLocationArr[self.row][self.col - 1]
            if left?.state == 1 {
                left = nil
            }
        }
        
        return left
    }
    
    func getRight() -> CircleLocation? {
        var right : CircleLocation? = nil
        if self.col < COL - 1 {
            right = self.circleLocationArr[self.row][self.col + 1]
            if right?.state == 1 {
                right = nil
            }
        }
        
        return right
    }
    
    func getLeftUp() -> CircleLocation? {
        var leftUp:CircleLocation? = nil
        if self.row % 2 != 0 {
            leftUp = self.circleLocationArr[self.row - 1][self.col]
        } else {
            if self.row > 0 && (self.col > 0){
                leftUp = self.circleLocationArr[self.row - 1][self.col - 1]
            }
        }
        
        if leftUp?.state == 1 {
            leftUp = nil
        }
        
        return leftUp
    }
    
    func getRightUp() -> CircleLocation? {
        var rightUp:CircleLocation? = nil
        if self.row % 2 == 0 {
            if self.row > 1 {
                rightUp = self.circleLocationArr[self.row - 1][self.col]
            }
        } else {
            if self.col < COL - 1{
                rightUp = self.circleLocationArr[self.row - 1][self.col + 1]
            }
        }
        
        if rightUp?.state == 1 {
            rightUp = nil
        }
        
        return rightUp
    }
    
    
    func getLeftDown() -> CircleLocation? {
        var leftDown:CircleLocation? = nil
        
        if self.row % 2 != 0 {
            leftDown = self.circleLocationArr[self.row + 1][self.col]
        } else {
            if self.col > 0 && (self.row < ROW - 1) {
                leftDown = self.circleLocationArr[self.row + 1][self.col - 1]
            }
        }
        
        if leftDown?.state == 1 {
            leftDown = nil
        }
        
        return leftDown
    }
    
    func getRightDown() -> CircleLocation? {
        var rightDown:CircleLocation? = nil
        
        if self.row % 2 == 0 {
            if self.row < ROW - 1 {
                rightDown = self.circleLocationArr[self.row + 1][self.col]
            }
        } else {
            if self.col < COL - 1 {
                rightDown = self.circleLocationArr[self.row + 1][self.col + 1]
            }
        }
        
        if rightDown?.state == 1 {
            rightDown = nil
        }
        
        return rightDown
    }
    
    func getAllCircles(array:[[CircleLocation]]) -> [CircleLocation] {
        self.circleLocationArr = array;
        
        var arr = [CircleLocation]()
        var left = getLeft();
        if let temp = left {
            arr.append(temp)
        }
        
        var right = getRight();
        if let temp = right {
            arr.append(temp)
        }
        
        var leftUp = getLeftUp();
        if let temp = leftUp {
            arr.append(temp)
        }
        
        var leftDown = getLeftDown();
        if let temp = leftDown {
            arr.append(temp)
        }
        
        var rightUp = getRightUp();
        if let temp = rightUp {
            arr.append(temp)
        }
        
        var rightDown = getRightDown();
        if let temp = rightDown {
            arr.append(temp)
        }
        
        return arr;
    }
    
    
}

