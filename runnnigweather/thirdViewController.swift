//
//  thirdViewController.swift
//  runnnigweather
//
//  Created by ISSHIN on 10/12/2016.
//  Copyright © 2016 ISSHIN. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController {

    @IBOutlet weak var thirdLabel: UILabel!
    
   // let image = UIImage(named:"IMG_0940.PNG")!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 画像サイズ、元画像が大きいので/5にしました
//        let rect = CGRect(x:0, y:0, width:image.size.width/5, height:image.size.height/5)
//        // UIImageView のインスタンス生成,ダミーでimage1を指定
//        let imageView:UIImageView = UIImageView(image:image)
//        imageView.frame = rect
//        // 画像が画面中央にくるように位置合わせ
//        let screenWidth = self.view.bounds.width
//        let screenHeight = self.view.bounds.height
//        imageView.center = CGPoint(x:screenWidth/2, y:screenHeight/2+50)
//        // view に追加する
//        self.view.addSubview(imageView)
        
        self.view.backgroundColor = UIColor(red:0.27, green:0.54, blue:1.00, alpha:1.0)
        thirdLabel.text = "Let's start!!!"
        thirdLabel.textColor = UIColor.white
        thirdLabel.numberOfLines = 0
        thirdLabel.adjustsFontSizeToFitWidth = true
        // Do any additional setup after loading the view.
            // スワイプ認識.
        let mySwipe = UISwipeGestureRecognizer(target: self, action: #selector(thirdViewController.swipeGesture(sender:)))
        // スワイプ認識-2本指でスワイプ.
        mySwipe.numberOfTouchesRequired = 1
        view.addGestureRecognizer(mySwipe)
    }
    func swipeGesture(sender: UISwipeGestureRecognizer){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "fuki") as! fukiViewController
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
