//
//  UrlViewController.swift
//  T-zap
//
//  Created by Masashi Takata on 2017/06/06.
//  Copyright © 2017年 Masashi Takata. All rights reserved.
//

import UIKit

class UrlViewController: UIViewController {
    var url: String = ""  //ViewControllerで選択した部位の行
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let machineURL = NSURL(string:url)
        // stringにはお好きなurlを入れてください。
        
        let urlRequest = NSURLRequest(url: machineURL! as URL)
        // urlをネットワーク接続が可能な状態にしている（らしい）
        
        webView.loadRequest(urlRequest as URLRequest)
        // 実際にwebViewにurlからwebページを引っ張ってくる。
        

        // Do any additional setup after loading the view.
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
