//
//  ViewController.swift
//  Chapter5-2
//
//  Created by 海野 颯汰   on 2024/08/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsの参照
        let userDefaults = UserDefaults.standard
        
        // UserDefaultsからtextキーに対応する値を参照
        if let value = userDefaults.string(forKey: "text"){
            // 取り出した値をテキストフィールドに設定
            textField.text = value
        }
    }

    @IBAction func tapActionButton(_ sender: Any) {
        // userDefaultsの参照
        let userDefaults = UserDefaults.standard
        
        // UserDefaultsにtextFieldの値を保存する
        userDefaults.set(textField.text, forKey: "text")
        
        // UserDefaultsの値を同期処理
        userDefaults.synchronize()
    }
}

