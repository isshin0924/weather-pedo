//
//  DrawView.swift
//  runnnigweather
//
//  Created by ISSHIN on 07/12/2016.
//  Copyright © 2016 ISSHIN. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.*/
    override func draw(_ rect: CGRect) {
        // Screen Size の取得
        let circlePoint = CGPoint(x:bounds.width/2, y:bounds.height/2)
        // 円のBezierPathを生成
        let outCircle: UIBezierPath = UIBezierPath(arcCenter: circlePoint,
            // 半径.
            radius: 180.0,
            // 初角度.
            startAngle: 0.0,
            // 最終角度.
            endAngle: CGFloat(M_PI*2),
            // 反時計回り.
            clockwise: false)
        
        // 線の色を赤色に設定.
        UIColor.white.setStroke()
        
        // 塗りつぶしの色を黄色に設定.
        //UIColor.yellow.setFill()
        
        outCircle.fill()
        
        // 線の太さを設定.
        outCircle.lineWidth = 10.0
        
        
        let outfillLayer = CAShapeLayer();
        outfillLayer.path = outCircle.cgPath;
        outfillLayer.fillColor = UIColor.clear.cgColor;
        layer.addSublayer(outfillLayer)
        // 描画.
        outCircle.stroke()
        
        
        let inCircle: UIBezierPath = UIBezierPath(
            arcCenter:circlePoint,
            radius: 170,
            startAngle: 0.0,
            endAngle: CGFloat(M_PI*2),
            clockwise: true)
        
        UIColor.clear.setStroke()
        inCircle.fill()
        inCircle.lineWidth = 8.0
        
        let infillLayer = CAShapeLayer();
        infillLayer.path = inCircle.cgPath;
        infillLayer.fillColor = UIColor.clear.cgColor;
        layer.addSublayer(infillLayer)
        
        inCircle.stroke()

    }
}
