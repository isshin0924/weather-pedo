//
//  firstWalkViewController.swift
//  runnnigweather
//
//  Created by ISSHIN on 09/12/2016.
//  Copyright © 2016 ISSHIN. All rights reserved.
//

import UIKit

class firstWalkViewController: UIViewController {
    
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var firstSlide: UILabel!
    
    //初回起動判定
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        if ud.bool(forKey: "firstLaunch") {
            
            
            self.view.backgroundColor = UIColor(red:0.27, green:0.54, blue:1.00, alpha:1.0)
            firstTitle.text = "Welcome"
            firstTitle.textColor = UIColor.white
            firstTitle.adjustsFontSizeToFitWidth = true
            firstSlide.textColor = UIColor.white
            firstSlide.adjustsFontSizeToFitWidth = true
            // スワイプ認識.
            let mySwipe = UISwipeGestureRecognizer(target: self, action: #selector(firstWalkViewController.swipeGesture(sender:)))
            // スワイプ認識-2本指でスワイプ.
            mySwipe.numberOfTouchesRequired = 1
            view.addGestureRecognizer(mySwipe)
            // 2回目以降の起動では「firstLaunch」のkeyをfalseに
            ud.set(false, forKey: "firstLaunch")
            ud.synchronize()
        }
        else{
            let secondViewController: UIViewController = self.storyboard?.instantiateViewController(withIdentifier: "fuki") as! fukiViewController
            // Viewの移動する.
            self.navigationController?.pushViewController(secondViewController, animated: false)
            
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
            }
    
    
    
    func swipeGesture(sender: UISwipeGestureRecognizer){
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "second") as! secondViewController
        self.present(nextView, animated: true, completion: nil)
    }
    
    //     func onClickMyButton(sender: UIButton){
    //
    //        let storyboard: UIStoryboard = self.storyboard!
    //        let nextView = storyboard.instantiateViewController(withIdentifier: "third") as! thirdViewController
    //        self.present(nextView, animated: true, completion: nil)
    //    print("hoge")
    //    }
    
    
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
