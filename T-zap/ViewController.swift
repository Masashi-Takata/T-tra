//
//  ViewController.swift
//  T-zap
//
//  Created by Masashi Takata on 2017/05/21.
//  Copyright © 2017年 Masashi Takata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    var myCollectionView2:UICollectionView!  //マシン設定

    @IBAction func goBack(_ segue:UIStoryboardSegue) {
    
    }
        
    //選択されたcellのindexPath.rowを保存しておくarray
    var partsIndex: Array<Int> = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PartsDataManager.sharedInstance.loadParts()  //部位のcsvファイルを読み込む処理
        self.view.backgroundColor = UIColor.white
        // CollectionViewCellのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 2.3, height: self.view.frame.width / 2.7) //セルのサイズ
        layout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10)  //セルの余白(上, 左, 下, 右)
        layout.headerReferenceSize = CGSize(width: 0,height: 0)  //セルのヘッダーサイズ
        layout.footerReferenceSize = CGSize(width: 0,height: 0)  //セルのフッダーサイズ
        
        
        // CollectionViewを生成.
        let frame = CGRect(x:0, y:20, width:self.view.frame.width, height:self.view.frame.height/5*4.6)  //定数frameに大きさを入れる
        myCollectionView2 = UICollectionView(frame: frame, collectionViewLayout: layout)  //myCollectionViewの大きさをframeにする
        myCollectionView2.register(PartsCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        myCollectionView2.delegate = self
        myCollectionView2.dataSource = self
        
        myCollectionView2.backgroundColor = UIColor.orange
        
        myCollectionView2.allowsMultipleSelection = true
        
        self.view.addSubview(myCollectionView2)  //ViewにCollectionViewを生成
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PartsDataManager.sharedInstance.partsDataArray.count  //セルの数を返す
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsCollectionViewCell
        //ここでcell.testViewなどcellのbackgroundViewにあるViewになにか必要な要素を配置する
        let partsData = PartsDataManager.sharedInstance.partsDataArray[indexPath.row]  //CSVファイルのマシンデータが定数machineDataに設定する
        
        cell.imageView?.image = partsData.image  //マシンの画像をセルのイメージに入れる
        cell.imageView!.contentMode = .scaleAspectFit  // これは縦横比を維持したままImageViewに収まるように縮小する設定
        self.view.sendSubview(toBack: cell.imageView!)
        cell.label.text = partsData.parts
        return cell
    }
    
    //選択された時に呼ばれる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsCollectionViewCell
        print(cell.isSelected)
        
        //選択された時に選択されているCellのindexPathを表示
        let selecteditems = self.myCollectionView2.indexPathsForSelectedItems
        print(selecteditems as Any)
        
        //チェックしたやつをmachineindexに入れる
        partsIndex.append(indexPath.row)
    }
    //選択状態から非選択状態になった時に呼ばれる.
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PartsCollectionViewCell
        print(cell.isSelected)
        
        partsIndex.remove(at: partsIndex.index(of: indexPath.row)!)  //非選択状態になった配列番号をindex(of: indexPath.row)で探してそれをpartsIndexからremoveする
    }

    
    
    
    
    
    //設定画面で選択した時間をメニュー表示画面に移す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMachineSelectViewController") {
            let secondViewController : MachineSelectViewController = segue.destination as! MachineSelectViewController  //セグエ先をMachineSelectViewControllerに設定し，そのViewCotrollerをMachineSelectViewController型変数secondViewControllerに入れる
            secondViewController.partsIndex = self.partsIndex  //ViewCotrollerの変数partsIndexをセグエ先のMachineSelectViewControllerのpartsIndexに入れる
        }
    }
    
}


////arrayの中での関数
//extension Array where Element: Equatable {
//    
//    // 先頭のオブジェクトのみ削除
//    mutating func remove(firstObject: Element) {
//        if let index = index(of: firstObject) {
//            remove(at: index)
//        }
//    }
//    
//    // すべてのオブジェクトを削除
//    mutating func remove(object: Element) {
//        if let index = index(of: object){
//            self.remove(at: index)
//            self.remove(object: object)
//        }
//    }
//    
//}




    
    




    //func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    




