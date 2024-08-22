//
//  ViewController.swift
//  Chapter5-3
//
//  Created by 海野 颯汰   on 2024/08/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsの生成
        let userDefaults = UserDefaults.standard
        
        // myDataのインスタンス化、valueStringにtestを設定
        let data = MyData()
        data.valueString = "test"
        
        do {
            // シリアライズ処理実行
            let archiveData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
            // UserDefaultsにシリアライズした値をセット
            userDefaults.set(archiveData, forKey: "data")
            userDefaults.synchronize()
            
            // UserDefaultsからシリアライズ処理されたデータを取り出す
            if let storedData = userDefaults.object(forKey: "data") as? Data{
                // デシリアライズ処理実行
                if let unarchiveData = try NSKeyedUnarchiver.unarchivedObject(ofClass: MyData.self, from: storedData){
                    if let valueString = unarchiveData.valueString {
                        print("デシリアライズデータ" + valueString)
                    }
                }
            }
        } catch{
            print("エラー" + "\(error)")
        }
    }


}

