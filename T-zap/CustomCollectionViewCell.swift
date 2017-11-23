//
//  CustomCollectionViewCell.swift
//  CheckBoxCollectionView
//
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    
    var imageView : UIImageView?  //写真を入れる箱を生成
    
    var label = UILabel()  //マシンの名前を入れるラベル生成
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        imageView = UIImageView(frame: CGRect(x:0, y:0, width:80, height:80))  //画像の大きさ設定
        self.addSubview(imageView!)  //写真をセルに追加する
        
        //画像のラベル設定
        label = UILabel(frame:CGRect(x:0,y:0,width:150,height:30))  //
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.layer.position = CGPoint(x:label.bounds.width/3.2,y:label.bounds.height/0.35)  //ラベルの位置設定
        label.font = UIFont.systemFont(ofSize: 6)
        
        self.contentView.addSubview(label)  //labelをセル内に追加
        //print(self.contentView.perform(Selector(("recursiveDescription"))))
        //こいつが悪さしてた
        
        
    }
}
