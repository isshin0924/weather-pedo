//
//  fukiViewController.swift
//  runnnigweather
//
//  Created by ISSHIN on 07/12/2016.
//  Copyright © 2016 ISSHIN. All rights reserved.
//

import UIKit
import CoreLocation
import CoreImage
import SystemConfiguration
import CoreMotion
import Foundation

class fukiViewController: UIViewController,CLLocationManagerDelegate,UINavigationControllerDelegate {
    //pedmeterコード
    var countStep:Int = 0
    var steps:Int = 0
    let pedometer = CMPedometer()
    // UserDefaults のインスタンス
    let userDefaults = UserDefaults.standard
    
    
    //天気情報コード
    var myLocationManager: CLLocationManager!
    var secondView:UIView!
    
    var humidty: UILabel!
    
    var temp: UILabel!
    
    //var label: UILabel!
    var weather:UILabel!
    let bWidth: CGFloat = 200
    let bHeight: CGFloat = 50
    let date = Date()
    let calendar = Calendar.current

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //背景画像の設定
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "wallpaper.jpg")?.draw(in: self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: image)

        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")
        if(hour >= 6 && hour < 16 ){
            print("morning")
            //secondView.backgroundColor = UIColor.white
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "road.jpg")?.draw(in: self.view.bounds)
            let image2: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            secondView.backgroundColor = UIColor(patternImage: image2)
        }
        if(hour >= 16 && hour < 19){print("evening")
            //SecondViewの表示
            secondView = UIView(frame: CGRect(x:0,y: view.bounds.width-30,width: 500,height: 500))
            //secondView.backgroundColor = UIColor.white
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "evening.png")?.draw(in: self.view.bounds)
            let image2: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            secondView.backgroundColor = UIColor(patternImage: image2)

        }
        if(hour >= 19){print("night")
            //SecondViewの表示
            secondView = UIView(frame: CGRect(x:0,y: view.bounds.width-30,width: 500,height: 500))
            //secondView.backgroundColor = UIColor.white
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "night.png")?.draw(in: self.view.bounds)
            let image2: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            secondView.backgroundColor = UIColor(patternImage: image2)

        }
        if(hour<=5){print("morning")
            //secondView.backgroundColor = UIColor.white
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "road.jpg")?.draw(in: self.view.bounds)
            let image2: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            secondView.backgroundColor = UIColor(patternImage: image2)
        }

        
        var lavelLabel = UILabel(frame: CGRect(x: 20, y: 20, width: self.view.bounds.width, height: 100))
        var label = UILabel(frame: CGRect(x: 20, y: 60, width: self.view.bounds.width, height: 100))
        
        lavelLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
            label.font = UIFont.boldSystemFont(ofSize: 40.0)
        label.textColor = UIColor.white
        lavelLabel.textColor = UIColor.white
        
        //pedometer
        if(CMPedometer.isStepCountingAvailable()){
            
            self.pedometer.startUpdates(from: NSDate() as Date) {
                (data: CMPedometerData?, error) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        // 歩数
                        self.steps = self.readData()
                        self.steps += Int(data!.numberOfSteps)
                        label.text = "Steps: \(self.steps)"
                        self.saveData(str: Int(self.steps))
                    }else{
                        label.text = "error"
                    }
                })
            }
            
            // デフォルト値
            userDefaults.register(defaults: ["DataStore": readData()])
            countStep = readData()
            lavelLabel.text = "TotallSteps:\(String(countStep))"
            var countBase:Int = Int(readData())+10
            var level = 1
            if readData()==countBase{
                
                var myDefault = UserDefaults.standard
                
                //データを書き込んで
                myDefault.set(countStep, forKey: "DataStore")
                
                //即反映させる
                myDefault.synchronize()
            }
            
        
        
            
            
        
//        //SecondViewの表示
//        secondView = UIView(frame: CGRect(x:0,y: view.bounds.width-30,width: 500,height: 500))
//        //secondView.backgroundColor = UIColor.white
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "road.jpg")?.draw(in: self.view.bounds)
//        let image2: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        secondView.backgroundColor = UIColor(patternImage: image2)
        
        
        // secondviewをviewに追加.
        self.view.addSubview(secondView)
        self.secondView.addSubview(label)
        self.secondView.addSubview(lavelLabel)
        
        //天気情報コード
        
        humidty = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        humidty.layer.position = CGPoint(x: 240, y:180)
        humidty.font = UIFont.boldSystemFont(ofSize: 30.0)
        humidty.adjustsFontSizeToFitWidth = true
        
        temp = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        temp.layer.position = CGPoint(x: 240, y:210)
        temp.font = UIFont.boldSystemFont(ofSize: 30.0)
        temp.adjustsFontSizeToFitWidth = true
        // 現在地の取得.
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        
        }
    }
    //ステータスバーを白色に
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        print("authorizationStatus:\(status.rawValue)");
        
        // まだ認証が得られていない場合は、認証ダイアログを表示
        // (このAppの使用中のみ許可の設定) 説明を共通の項目を参照
        if(status == .notDetermined) {
            self.myLocationManager.requestAlwaysAuthorization()
        }
        
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得頻度の設定.
        myLocationManager.distanceFilter = 100
        // 現在位置の取得を開始.
        myLocationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        self.view.addSubview(humidty)
        self.view.addSubview(temp)
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(String(manager.location!.coordinate.latitude))&lon=\(String(manager.location!.coordinate.longitude))&APPID=47a738728ecba24e1da71b745ada7b08")
        let request = URLRequest(url:url!)
        print(request)
        if CheckReachability(host_name: "google.com") {
            var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
            print("hoge")
            let jsonDictionary = (try! JSONSerialization.jsonObject(with: jsondata, options: [])) as! NSDictionary
            for(key, data) in jsonDictionary{
                if (key as! String == "weather"){
                    var resultArray = data as! NSArray
                    for (eachWether) in resultArray{
                        var wether:NSDictionary = eachWether as! NSDictionary
                        self.weather.text = String(describing: wether["main"]!)
                        self.weather.textColor = UIColor.white
                        if String(describing: wether["main"]!)=="Sunny"  {
                            UIGraphicsBeginImageContext(self.view.frame.size)
                            UIImage(named: "sunnywall.png")?.draw(in: self.view.bounds)
                            let image1: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            view.backgroundColor = UIColor(patternImage: image1)
                        }
                        if String(describing: wether["main"]!)=="Rainy"  {
                            UIGraphicsBeginImageContext(self.view.frame.size)
                            UIImage(named: "rainywall.png")?.draw(in: self.view.bounds)
                            let image1: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            view.backgroundColor = UIColor(patternImage: image1)
                        }
                        if String(describing: wether["main"]!)=="Thunderstorm"  {
                            UIGraphicsBeginImageContext(self.view.frame.size)
                            UIImage(named: "thunderwall.png")?.draw(in: self.view.bounds)
                            let image1: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
                            UIGraphicsEndImageContext()
                            view.backgroundColor = UIColor(patternImage: image1)
                        }

                    }
                }
                
                if (key as! String == "main") {
                    var result = data as! NSDictionary
                    self.humidty.text = "Humidty:\(String(describing:result["humidity"]!))"
                    self.temp.text = "Temperature:\(String(describing:result["temp_min"]as!Int-273))/\(String(describing:result["temp_max"]as!Int-273))"
                    self.temp.textColor = UIColor.white
                    self.humidty.textColor = UIColor.white
                }
                // Labelを作成.
                self.weather = UILabel(frame: CGRect(x: 10, y: 80, width: self.bWidth, height: self.bHeight))
                // フォント
                weather.font = UIFont.boldSystemFont(ofSize: 60.0)
                // 文字がはみ出さないようにサイズをフィットさせる
                weather.adjustsFontSizeToFitWidth = true
                // Textを中央寄せにする.
                weather.textAlignment = NSTextAlignment.center
                //viewに追加
                self.view.addSubview(weather)
            }
        }else{
            let alertController = UIAlertController(title: "No Network", message: "This app cannot use \n If you don't connect with Network", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    func CheckReachability(host_name:String)->Bool{
        let reachability = SCNetworkReachabilityCreateWithName(nil, host_name)!
        var flags = SCNetworkReachabilityFlags.connectionAutomatic
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    func saveData(str: Int){
        
        // Keyを指定して保存
        userDefaults.set(str, forKey: "DataStore")
        userDefaults.synchronize()
    }
    
    func readData() -> Int {
        // Keyを指定して読み込み
        var int = userDefaults.object(forKey: "DataStore")
        if(int==nil) {
            int=0
            return int as! Int
        }else{
            return int as! Int
        }
    }
    }
