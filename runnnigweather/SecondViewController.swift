//
//  secondWalkViewController.swift
//  runnnigweather
//
//  Created by ISSHIN on 09/12/2016.
//  Copyright © 2016 ISSHIN. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var secondtitle: UILabel!
    @IBOutlet weak var RightLabel: UILabel!
    var myImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画像サイズ、元画像が大きいので/5にしました
                // 画像が画面中央にくるように位置合わせ
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        let iWidth: CGFloat = 300
        let iHeight: CGFloat = 100
        
        // UIImageViewのx,yを設定する
        let posX: CGFloat = (self.view.bounds.width - iWidth)
        let posY: CGFloat = (self.view.bounds.height - iHeight)
        
        // UIImageViewを作成.
        myImageView = UIImageView(frame: CGRect(x: posX, y: posY, width: iWidth, height: iHeight))

        let myimage:UIImage = UIImage(named:"IMG_0940.PNG")!
        let rect = CGRect(x:0, y:0, width:myimage.size.width/5, height:myimage.size.height/5)
        // UIImageView のインスタンス生成,ダミーでimage1を指定
        myImageView.frame = rect

        myImageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2+50)
        // view に追加する
        myImageView.image = myimage
        
        self.view.backgroundColor = UIColor(red:0.27, green:0.54, blue:1.00, alpha:1.0)
        secondtitle.text = "This app can\n count your steps and\n check weather.\n"
        secondtitle.textColor = UIColor.white
        secondtitle.numberOfLines = 0
        secondtitle.adjustsFontSizeToFitWidth = true
//        LeftLabel.textColor = UIColor.white
//        LeftLabel.adjustsFontSizeToFitWidth = true
        RightLabel.textColor = UIColor.white
        RightLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
        self.view.addSubview(myImageView)

        // スワイプ認識.
        let mySwipe = UISwipeGestureRecognizer(target: self, action: #selector(secondViewController.swipeGesture(sender:)))
        // スワイプ認識-2本指でスワイプ.
        mySwipe.numberOfTouchesRequired = 1
        view.addGestureRecognizer(mySwipe)
    }
    func swipeGesture(sender: UISwipeGestureRecognizer){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "third") as! thirdViewController
        self.present(nextView, animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
