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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var background = UIImageView(frame: CGRectMake(0, 0, 320, 480))
        background.image = UIImage(named: "background1.png")
        self.view.addSubview(background)
    
        addAllBtns();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func addAllBtns() {
        for i in 0..<9 {
            var rowBtn = [UIButton]()
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
            }
            allBtnArray.append(rowBtn)
        }
    }
    
    func clickBtn(sender:UIButton) {
        sender.setImage(UIImage(named: "yellow2.png"), forState: UIControlState.Normal)
    }

}

