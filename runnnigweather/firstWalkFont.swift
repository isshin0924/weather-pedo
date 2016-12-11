import UIKit
class UILabelSample: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        let label: UILabel = UILabel(frame: CGRect(x:0,y: 0,width: 200,height: 50))
        self.addSubview(label)
        label.center = self.center
        
        // 背景色
        label.backgroundColor = UIColor.blue
        
        // 文字
        label.text = "Label.text"
        
        // フォント
        label.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        // 文字がはみ出さないようにサイズをフィットさせる
        label.adjustsFontSizeToFitWidth = true
        
        // 行数を変更(デフォルトは1, 0だと行数無制限)
        label.numberOfLines = 0
        
        // 文字色
        label.textColor = UIColor.white
        
        // 文字の影の色
        label.shadowColor = UIColor.black
        
        // 文字の影の位置
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        // 影の色
        label.layer.shadowColor = UIColor.black.cgColor
        
        // 影の不透明度
        label.layer.shadowOpacity = 0.5
        
        // 影の位置
        label.layer.shadowOffset = CGSize(width:10,height: 10)
        
        // 位置
        label.textAlignment = NSTextAlignment.center
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
