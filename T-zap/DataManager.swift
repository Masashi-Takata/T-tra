//
//  DataManager.swift
//  T-zap
//
//  Created by Masashi Takata on 2017/06/05.
//  Copyright © 2017年 Masashi Takata. All rights reserved.
//

import Foundation
import UIKit

//部位に関する情報を格納するデータクラス
class Parts{
    var partsNumber: Int  //部位番号
    var parts: String?  //部位
    var image : UIImage!  //nilが入ってもいい
    
        
    //クラスが生成された時の処理
    init(partsSourceDataArray: [String]){
        partsNumber = Int(partsSourceDataArray[0])!
        parts = partsSourceDataArray[1]
        image = UIImage(named: partsSourceDataArray[2])!  //Imageにマシン画像ファイル名を代入
       

    }
    
    }


//部位を管理するクラス
class PartsDataManager{
    //シングルトンオブジェクトの宣言
    static let sharedInstance = PartsDataManager() //QuestionDataManagerクラスをシェアするため
    
    //部位を格納するための配列
    var partsDataArray = [Parts]()

    
    //初期化処理
    private init(){
        //シングルトンであることを保証するためにprivateで宣言しておく
    }
    
    //部位の読み込み処理
    func loadParts(){
        
        partsDataArray.removeAll()  //格納済みの問題文があれば一旦削除しておく
        //CSVファイルパスを取得
        guard let csvFilePath =  Bundle.main.path(forResource: "parts",ofType: "csv") else {
            //csvファイルなし
            print("csvファイルがありません")
            return
        }
        
        //CSVデータ読み込み
        do {
            //(do try catch)は1セット
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8) //文字列型変数csvStringDataに引数はcsvFilePath，文字コードはString.Encoding.utf8と指定にしたものを代入
            //CSVデータを1行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line,stop) in
                //カンマ区切りで分割
                let partsSourceDataArray = line.components(separatedBy: ",")
                //問題データを格納するオフジェクトを作成
                let partsData = Parts(partsSourceDataArray: partsSourceDataArray)
                //問題文を追加
                self.partsDataArray.append(partsData)
                
            })
            
        } catch let error {
            //ファイル読み込みエラー時
            print("csvファイル読み込みエラーが発生しました:\(error)")
            return
        }
}
}


//マシンに関する情報を格納するデータクラス
class MachineData{
    var partsNumber: Int  //部位番号
    var machineName : String = ""
    var image : UIImage!  //nilが入ってもいい
    var url : String = ""
    
    //クラスが生成された時の処理
    init(machineSourceDataArray: [String]){
        machineName = machineSourceDataArray[0]  //machineNameにマシン名を代入
        image = UIImage(named: machineSourceDataArray[1])!  //Imageにマシン画像ファイル名を代入
        partsNumber = Int(machineSourceDataArray[2])!  //partsNumberに部位番号を代入
        url = machineSourceDataArray[3]  //URLを代入
    }
}


//マシンを管理するクラス
class machineDataManager{
    //シングルトンオブジェクトの宣言
    static let sharedInstance = machineDataManager() //MachineDataManagerクラスをシェアするため
    
    //部位を格納するための配列
    var machineDataArray = [MachineData]()
    
    
    //初期化処理
    private init(){
        //シングルトンであることを保証するためにprivateで宣言しておく
    }
    
    //部位の読み込み処理
    func loadMachine(){
        machineDataArray.removeAll()  //格納済みがあれば一旦削除しておく
        
        
        //CSVファイルパスを取得
        guard let csvFilePath =  Bundle.main.path(forResource: "machinedata",ofType: "csv") else {
            //csvファイルなし
            print("csvファイルがありません")
            return
        }
        
        //CSVデータ読み込み
        do {
            //(do try catch)は1セット
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8) //文字列型変数csvStringDataに引数はcsvFilePath，文字コードはString.Encoding.utf8と指定にしたものを代入
            //CSVデータを1行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line,stop) in
                //カンマ区切りで分割
                let machineSourceDataArray = line.components(separatedBy: ",")
                //問題データを格納するオフジェクトを作成
                let machineData = MachineData(machineSourceDataArray: machineSourceDataArray)
                //問題文を追加
                self.machineDataArray.append(machineData)
                //問題番号を設定
            })
            
        } catch let error {
            //ファイル読み込みエラー時
            print("csvファイル読み込みエラーが発生しました:\(error)")
            return
        }
    }
}

