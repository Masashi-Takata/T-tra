//
//  ViewController.swift
//  T-zap
//
//  Created by Masashi Takata on 2017/05/21.
//  Copyright © 2017年 Masashi Takata. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var partsAndTimeView: UIPickerView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    //マシン名
    var machine = ["ベンチプレス","ラットプルマシン", "ローイングマシン", "ペックデック", "ディップススタンド", "マルチプレス", "レッグプレスマシン", "カーフレイズマシン", "リアデルトマシン","レッグエクステンションマシン","レッグカールマシン"]
    
    //選択されたcellのindexPath.rowを保存しておくarray
    var machineindex: Array<Int> = []
    
    //コンポーネントに表示する項目名
    let compos = [["30分","60分","90分"],["腕","肩","背中","胸","腹筋","全身","上半身","下半身"]]
    
    //ピッカービューのコンポーネントの個数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return compos.count  //2を返すので，コンポーネントは2個作られる
    }
    
    //各コンポーネントの行数を返す
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let compo = compos[component]  //値が入った配列を取り出す
        return compo.count  //値の個数が行数になります
    }
    
    //各コンポーネントの横幅を返す
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        //1個目のコンポーネント
        if component == 0 {
            //筋トレ時間
            return 100
        } else {
            //鍛えたい部位
            return 100
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //指定のコンポーネントから指定行の項目名を取り出す
        let item = compos[component][row]  //２次元配列から値を取り出す
        return item
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ViewControllerクラスがpartsAndTimeViewのデリゲートになる（命令する）
        partsAndTimeView.delegate = self
        //ViewControllerクラスがpartsAndTimeViewのデータソースになる(サイズ変更する)
        partsAndTimeView.dataSource = self
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // trueで複数選択、falseで単一選択
        tableView.allowsMultipleSelection = true
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        self.view.addSubview(tableView)
    }
    
    // セルが選択された時に呼び出される
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを入れる
        cell?.accessoryType = .checkmark
        //チェックしたやつをmachineindexに入れる
        machineindex.append(indexPath.row)
        
    }
    
    // セルの選択が外れた時に呼び出される
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at:indexPath)
        
        // チェックマークを外す
        cell?.accessoryType = .none
        //チェックしていないやつをmachineindexから外す
        machineindex.remove(object: indexPath.row)
    }
    
    // セルの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return machine.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(machine[indexPath.row])"
        
        //self.machineindex.count >= 1はmachineindexに配列があるか
        //self.machineindex.contains(indexPath.row)はmachineindexにindexPath.rowが含まれてたら
        if (self.machineindex.count >= 1) && self.machineindex.contains(indexPath.row)  {
            cell.accessoryType = .checkmark //チェックマークを入れる
            }
        else {
            cell.accessoryType = .none  //チェックマークを外す

        }
        
        // セルが選択された時の背景色を消す
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
}
extension Array where Element: Equatable {
    
    // 先頭のオブジェクトのみ削除
    mutating func remove(firstObject: Element) {
        if let index = index(of: firstObject) {
            remove(at: index)
        }
    }
    
    // すべてのオブジェクトを削除
    mutating func remove(object: Element) {
        if let index = index(of: object){
            self.remove(at: index)
            self.remove(object: object)
        }
    }
    
}



    //func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    




