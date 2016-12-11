//
//  fuki.swift
//  runnnigweather
//
//  Created by ISSHIN on 07/12/2016.
//  Copyright © 2016 ISSHIN. All rights reserved.
//

import UIKit

class fuki: UIView {
    
    let triangleSideLength: CGFloat = 20
    let triangleHeight: CGFloat = 17.3
    
    override func draw(_ rect: CGRect) {
        
        //以下のコードは本当はviewcontrollerの方に入れる
        //吹き出しコード
        //        let balloon = fuki(frame: CGRect(x:(view.bounds.size.width - 280) / 2,y: 350,width: 280,height: 100))
        //        balloon.backgroundColor = UIColor.clear
        //        view.addSubview(balloon)
        //        let label = UILabel(frame: balloon.bounds)
        //        label.frame.origin.y -= 8.7
        //        label.text = "Today is Sunny!!"
        //        label.textColor = UIColor.black
        //        label.font = UIFont.boldSystemFont(ofSize: 24)
        //        label.textAlignment = .center
        //        balloon.addSubview(label)
        //        let imageView = UIImageView()
        //        imageView.frame.size = CGSize(width:100,height:100)
        //        imageView.frame.origin.y = balloon.frame.maxY + 20
        //        imageView.center.x = balloon.center.x-150
        //        imageView.layer.cornerRadius = 50
        //        imageView.image = UIImage(named: "sunny.png")
        //        imageView.contentMode = .scaleAspectFill
        //        imageView.clipsToBounds = true
        //        view.addSubview(imageView)

        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.white.cgColor)
        contextBalloonPath(context: context!, rect: rect)
    }
    
    func contextBalloonPath(context: CGContext, rect: CGRect) {
        let triangleRightCorner = (x: (rect.size.width + triangleSideLength) / 2, y: rect.maxY - triangleHeight)
        let triangleBottomCorner = (x: rect.size.width / 2, y: rect.maxY)
        let triangleLeftCorner = (x: (rect.size.width - triangleSideLength) / 2, y: rect.maxY - triangleHeight)
        // 塗りつぶし
        context.addRect(CGRect(x:0,y: 0,width: 280,height: rect.size.height - triangleHeight))
        context.fillPath()
        print(triangleLeftCorner.x)
        print(triangleLeftCorner.y)
        context.move(to: CGPoint(x:10,y:20))
        context.addLine(to: CGPoint(x:20,y:triangleBottomCorner.y))
        context.addLine(to: CGPoint(x:30,y:triangleRightCorner.y))
        context.fillPath()
    }
}


