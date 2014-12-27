//
//  ViewController.swift
//  WeiZhuShengJingMao
//
//  Created by lsw on 14-12-24.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

import UIKit

let ROW = 9
let COL = 9

class ViewController: UIViewController {

    var allBtnArray = [[UIButton]]()
    var allBtnState = [[Int]]()
    var allCircleLoc = [[CircleLocation]]()
    var catImageView = UIImageView()
    var catCircle:CircleLocation!
    var totleNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var background = UIImageView(frame: CGRectMake(0, 0, 320, 480))
        background.image = UIImage(named: "background1.png")
        self.view.addSubview(background)
    
        addAllBtns()
        addCat()
        addGameLevel()
        addAllCircleLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAllCircleLocation() {
        for i in 0..<ROW {
            var rowCircleLoc = [CircleLocation]()
            for j in 0..<COL {
                var loc = CircleLocation(row: i, col: j)
                rowCircleLoc.append(loc)
                loc.state = allBtnState[i][j]
            }
            
            allCircleLoc.append(rowCircleLoc)
        }
    }
    
    func addGameLevel() {
        var gameLevel = (Int)(arc4random() % 20 + 10)
        var wallNums = 0
        while wallNums < gameLevel {
            let rowNum = (Int)(arc4random() % 9)
            let colNum = (Int)(arc4random() % 9)
            if allBtnState[rowNum][colNum] == 0 {
                allBtnArray[rowNum][colNum].setImage(UIImage(named: "yellow2.png"), forState: UIControlState.Normal)
                wallNums++
                allBtnState[rowNum][colNum] = 1
            }
        }
    }

    func addCat() {
        catImageView.frame = CGRectMake((CGFloat)(20 + 28 * 4), (CGFloat)(170 + 28 * 3), 28, 56)
        var img1 = UIImage(named: "left2.png")
        var img2 = UIImage(named: "middle2.png")
        var img3 = UIImage(named: "right2.png")
        catImageView.animationImages = [img1!, img2!, img3!]
        catImageView.animationDuration = 1.0
        catImageView.startAnimating()
        self.view.addSubview(catImageView)
        allBtnState[4][4] = 1
        catCircle = CircleLocation(row: 4, col: 4)
        catCircle.state = 0
    }
    
    func addAllBtns() {
        for i in 0..<ROW {
            var rowBtn = [UIButton]()
            var rowBtnState = [Int]()
            for j in 0..<COL {
                var btn = UIButton()
                if i % 2 == 0 {
                    btn.frame = CGRectMake((CGFloat)(20 + 28 * j), (CGFloat)(170 + 28 * i), 28, 28)
                } else {
                    btn.frame = CGRectMake((CGFloat)(20 + 28 * j + 14), (CGFloat)(170 + 28 * i), 28, 28)
                }
                
                btn.setImage(UIImage(named: "gray.png"), forState: UIControlState.Normal)
                btn.addTarget(self, action: "clickBtn:", forControlEvents: UIControlEvents.TouchUpInside)
                self.view.addSubview(btn)
                rowBtn.append(btn)
                rowBtnState.append(0)
            }
            allBtnState.append(rowBtnState)
            allBtnArray.append(rowBtn)
        }
    }
    
    func clickBtn(sender:UIButton) {
        sender.setImage(UIImage(named: "yellow2.png"), forState: UIControlState.Normal)
        var clickRow = getClickBtnRow(sender)
        var clickCol = getClickBtnCol(sender)
        allBtnState[clickRow][clickCol] = 1
        allCircleLoc[clickRow][clickCol].state = allBtnState[clickRow][clickCol]
        totleNum++
        catMove()
    }
    
    func catMove() {
        getBestLocation()
        if catCircle.row % 2 == 0 {
            catImageView.frame = CGRectMake((CGFloat)(20 + 28 * catCircle.col), (CGFloat)(170 + 28 * (catCircle.row - 1)), 28, 56)
        } else {
            catImageView.frame = CGRectMake((CGFloat)(20 + 28 * catCircle.col + 14), (CGFloat)(170 + 28 * (catCircle.row - 1)), 28, 56)
        }
    }
    
    func getBestLocation() {
        calculateAllCost()
        
        var circle = allCircleLoc[catCircle.row][catCircle.col]
        var tempArr = circle.getAllCircles(allCircleLoc)
        
        if tempArr.count > 0 {
            var selectCircle = tempArr[0]
            for temp in tempArr {
                if temp.isBoundary() {
                    println("You lose")
                    loseAlert()
                    return
                }
                if selectCircle.isLess(temp) {
                    continue
                } else {
                    selectCircle = temp
                }
            }
            
            catCircle.row = selectCircle.row
            catCircle.col = selectCircle.col
            catCircle.state = selectCircle.state
        } else {
            if catCircle.isBoundary() {
                println("You lose")
                loseAlert()
            } else {
                println("You win")
                winAlert()
            }
        }
    }
    
    func calculateAllCost() {
        clearAllCost()
        
        for i in 0 ..< ROW {
            for j in 0 ..< COL {
                var circle = allCircleLoc[i][j]
                circle.calculateCost(allCircleLoc)
                println("\(i) and \(j) cost = \(circle.cost)")
            }
        }
        
    }
    
    func clearAllCost() {
        for i in 0 ..< ROW {
            for j in 0 ..< COL {
                var circle = allCircleLoc[i][j]
                circle.cost = -100
            }
        }
    }
    
    func getClickBtnRow(btn:UIButton) -> Int {
        let y = Int(btn.frame.origin.y)
        let row = (y - 170)/28;
        return row;
    }
    
    func getClickBtnCol(btn:UIButton) -> Int {
        var row = getClickBtnRow(btn)
        let x = Int(btn.frame.origin.x)
        var col = 0
        if row % 2 == 0 {
            col = (x - 20) / 28
        } else {
            col = (x - 34) / 28
        }
        
        return col
    }
    
    func runAgain() {
        totleNum = 0
        for i in 0 ..< ROW {
            for j in 0 ..< COL {
                allBtnArray[i][j].setImage(UIImage(named: "gray.png"), forState: UIControlState.Normal)
                allBtnState[i][j] = 0
            }
        }
        
        allBtnState[4][4] = 1
        catImageView.frame = CGRectMake((CGFloat)(20 + 28 * 4), (CGFloat)(170 + 28 * 3), 28, 56)
        catCircle.row = 4
        catCircle.col = 4
        catCircle.state = 0
        
        addGameLevel()
        for i in 0..<ROW {
            for j in 0 ..< COL {
                allCircleLoc[i][j].state = allBtnState[i][j]
            }
        }
    }
    
    func winAlert() {
        var alert = UIAlertController(title: "You Win!", message: "你围住了神经猫，总共是\(totleNum)步", preferredStyle: UIAlertControllerStyle.Alert)
        var actionOk = UIAlertAction(title: "退出游戏", style: UIAlertActionStyle.Default, handler: {act in exit(-1)})
        var actionCancle = UIAlertAction(title: "重新开始", style: UIAlertActionStyle.Default, handler: {act in self.runAgain()})
        alert.addAction(actionOk)
        alert.addAction(actionCancle)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loseAlert() {
        var alert = UIAlertController(title: "You losw!", message: "小猫跑掉了", preferredStyle: UIAlertControllerStyle.Alert)
        var actionOk = UIAlertAction(title: "again?", style: UIAlertActionStyle.Default, handler: {act in self.runAgain()})
        var actionNo = UIAlertAction(title: "give up", style: UIAlertActionStyle.Default, handler: {act in exit(-1)})
        alert.addAction(actionOk)
        alert.addAction(actionNo)
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

