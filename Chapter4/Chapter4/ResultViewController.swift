//
//  ResultViewController.swift
//  Chapter4
//
//  Created by 海野 颯汰   on 2024/08/21.
//

import UIKit

class ResultViewController: UIViewController {

    var price: Int = 0
    
    let percentValue: Float = 0.1
    
    @IBOutlet weak var resultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 割引額を計算
        let waribikiPrice = Float(price) * percentValue
        // 割引後の値段を計算
        let percentOffPrice = price - Int(waribikiPrice)
        // 結果フィールドに最終値段をセット
        resultField.text = "\(percentOffPrice)"
    }
    
}
