//
//  ViewController.swift
//  WeiZhuShengJingMao
//
//  Created by lsw on 14-12-24.
//  Copyright (c) 2014年 lsw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var allBtnArray = [[UIButton]]()
    var allBtnState = [[Int]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var background = UIImageView(frame: CGRectMake(0, 0, 320, 480))
        background.image = UIImage(named: "background1.png")
        self.view.addSubview(background)
    
        addAllBtns()
        addCat()
        addGameLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        var catImageView = UIImageView()
        catImageView.frame = CGRectMake((CGFloat)(20 + 28 * 4), (CGFloat)(170 + 28 * 3), 28, 56)
        var img1 = UIImage(named: "left2.png")
        var img2 = UIImage(named: "middle2.png")
        var img3 = UIImage(named: "right2.png")
        catImageView.animationImages = [img1!, img2!, img3!]
        catImageView.animationDuration = 1.0
        catImageView.startAnimating()
        self.view.addSubview(catImageView)
        allBtnState[4][3] = 1
    }
    
    func addAllBtns() {
        for i in 0..<9 {
            var rowBtn = [UIButton]()
            var rowBtnState = [Int]()
            for j in 0..<9 {
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
    }

}

