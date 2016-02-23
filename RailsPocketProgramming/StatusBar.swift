//
//  StatusBar.swift
//  RailsPocketProgramming
//
//  Created by kiiita on 2015/12/08.
//  Copyright © 2015年 ffab0. All rights reserved.
//

import Foundation

class StatusBar {
    static func setColor(parentVC: UIViewController) {
        let statusBarBackground = UIView(frame: CGRectMake(0 , 0, CGRectGetWidth(parentVC.view.frame)+40, CGRectGetHeight(UIApplication.sharedApplication().statusBarFrame)))
        statusBarBackground.backgroundColor = UIColor(rgba: "#AF353D")
        parentVC.view.addSubview(statusBarBackground)
    }
}