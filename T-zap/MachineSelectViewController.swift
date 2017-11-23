//
//  MachineSelectViewController.swift
//  T-zap
//
//  Created by Masashi Takata on 2017/06/04.
//  Copyright © 2017年 Masashi Takata. All rights reserved.
//

import UIKit

class MachineSelectViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
    
    @IBAction func goBack(_ segue:UIStoryboardSegue) {
        
    }
    
    
    
    var myCollectionView:UICollectionView!  //マシン設定
    
    var partsIndex: Array<Int> = []  //ViewControllerで選択した部位の行
    var selectedRow = 0  //選択されたマシンのURLを代入
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        machineDataManager.sharedInstance.loadMachine()  //マシンのcsvファイルを読み込む処理
        
        // CollectionViewCellのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width / 4.5, height: self.view.frame.width / 4.5) //セルのサイズ
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10)  //セルの余白(上, 左, 下, 右)
        layout.headerReferenceSize = CGSize(width: 0,height: 0)  //セルのヘッダーサイズ
        layout.footerReferenceSize = CGSize(width: 0,height: 0)  //セルのフッダーサイズ
        
        
        // CollectionViewを生成.
        let frame = CGRect(x:0, y:10, width:self.view.frame.width, height:self.view.frame.height / 6 * 5.5)  //定数frameに大きさを入れる
        myCollectionView = UICollectionView(frame: frame, collectionViewLayout: layout)  //myCollectionViewの大きさをframeにする
        myCollectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.backgroundColor = UIColor.white
        
        myCollectionView.allowsMultipleSelection = true
        
        self.view.addSubview(myCollectionView)  //ViewにCollectionViewを生成
    }
    
    //MARK:- UICollectionViewDataSorce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return machineDataManager.sharedInstance.machineDataArray.count  //セルの数を返す
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        //ここでcell.testViewなどcellのbackgroundViewにあるViewになにか必要な要素を配置する
        let machineData = machineDataManager.sharedInstance.machineDataArray[indexPath.row]  //CSVファイルのマシンデータが定数machineDataに設定する
        
        cell.imageView?.image = machineData.image  //マシンの画像をセルのイメージに入れる
        cell.imageView!.contentMode = .scaleAspectFit  // これは縦横比を維持したままImageViewに収まるように縮小する設定
        //選択していない部位に対応するマシンの場合(self.partsIndexは「部位を選んだ行」，.containsは「に含まれる」，machineData.partsNumberは「マシンデータcsvファイルの部位番号」)
        if self.partsIndex.contains(machineData.partsNumber) {
            cell.isUserInteractionEnabled = true  //選択可
            cell.imageView?.alpha = 1  //画像を不透明にする
            cell.label.alpha = 1  //ラベルを透明にする
        } else {
            cell.isUserInteractionEnabled = false  //選択不可
            cell.imageView?.alpha = 0.1  //画像を透明にする
            cell.label.alpha = 0.1  //ラベルを透明にする
        }
        
        self.view.sendSubview(toBack: cell.imageView!)
        cell.label.text = machineData.machineName
        return cell
    }
    
    //選択された時に呼ばれる
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        print(cell.isSelected)
        
        //選択された時に選択されているCellのindexPathを表示
        let selecteditems = self.myCollectionView.indexPathsForSelectedItems
        print(selecteditems as Any)
        
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "toUrlViewController", sender: nil)  //セグエを行う
    }
    //選択状態から非選択状態になった時に呼ばれる.
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomCollectionViewCell
        print(cell.isSelected)
    }
    
    //設定画面で選択した時間をメニュー表示画面に移す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toUrlViewController") {
            let thirdViewController : UrlViewController = segue.destination as! UrlViewController  //セグエ先をMachineSelectViewControllerに設定し，そのViewCotrollerをMachineSelectViewController型変数secondViewControllerに入れる
            let machineData = machineDataManager.sharedInstance.machineDataArray[self.selectedRow]
            thirdViewController.url =  machineData.url  //ViewCotrollerの変数partsIndexをセグエ先のMachineSelectViewControllerのpartsIndexに入れる
        }
    }
    
    
}






//func didReceiveMemoryWarning() {
//super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.





