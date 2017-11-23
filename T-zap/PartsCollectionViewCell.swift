//
//  PartsCollectionViewController.swift
//  T-zap
//
//  Created by Masashi Takata on 2017/06/07.
//  Copyright © 2017年 Masashi Takata. All rights reserved.
//

import UIKit

class PartsCollectionViewCell: UICollectionViewCell {
    
    
    var imageView : UIImageView?  //写真を入れる箱を生成
    
    var label = UILabel()  //マシンの名前を入れるラベル生成
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        imageView = UIImageView(frame: CGRect(x:20, y:0, width:120, height:140))  //画像の大きさ設定
        //self.backgroundView = imageView//セルの背景を画像に設定
        self.addSubview(imageView!)  //写真をセルに追加する
        
        //画像のラベル設定
        label = UILabel(frame:CGRect(x:0,y:0,width:200,height:45))  //
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.layer.position = CGPoint(x:label.bounds.width/2.6,y:label.bounds.height/0.35)  //ラベルの位置設定
        label.font = UIFont.systemFont(ofSize: 10)
        
        self.contentView.addSubview(label)  //labelをセル内に追加
        //print(self.contentView.perform(Selector(("recursiveDescription"))))
        //こいつが悪さしてた
        
        
        let boxSize = frame.width * 0.15
        
        let falseBox = CheckBoxView(frame: CGRect(x: 0, y: 0, width: boxSize, height: boxSize), selected: false)
        self.addSubview(falseBox)
        
        let trueBox = CheckBoxView(frame: CGRect(x: 0, y: 0, width: boxSize, height: boxSize), selected: true)
        let backView = UIView(frame: frame)
        backView.backgroundColor = UIColor.clear
        backView.addSubview(trueBox)
        self.selectedBackgroundView = backView
    }
}
