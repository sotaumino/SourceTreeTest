//
//  ViewController.swift
//  Chapter5-4
//
//  Created by 海野 颯汰   on 2024/08/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var todoList = [MyTodo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        let userDefaults = UserDefaults.standard
        if let storedTodoList = userDefaults.object(forKey: "todoList") as? Data {
            do{
                // デシリアライズ処理
                if let unarchiveTodoList = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, MyTodo.self], from: storedTodoList) as? [MyTodo]{
                    todoList.append(contentsOf: unarchiveTodoList)
                }
            }catch{
            print("エラー")
            }
        }
    }

    @IBAction func tapAddButton(_ sender: Any) {
        // アラートダイアログ生成
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを入力してください", preferredStyle: UIAlertController.Style.alert)
        // テキストエリアを追加
        alertController.addTextField(configurationHandler: nil)
        // OKボタンを追加
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (alertAction) in
            // OKボタンがタップされた時の処理
            if let textField = alertController.textFields?.first{
                // 配列の先頭に入力値を挿入。
                let myTodo = MyTodo()
                myTodo.todoTitle = textField.text!
                // todoListの先頭に入力値を挿入
                self.todoList.insert(myTodo, at: 0)
                // テーブルに行が追加されたことを通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                // todoの保存処理
                let userDefaults = UserDefaults.standard
                // Data型にシリアライズ処理
                do{
                    let data = try NSKeyedArchiver.archivedData(withRootObject: self.todoList, requiringSecureCoding: true)
                    userDefaults.set(data, forKey: "todoList")
                    userDefaults.synchronize()
                }catch{
                    print("エラー")
                }
            }
        }
        // okボタンがタップされた時の処理
        alertController.addAction(okAction)
        // Cancelボタンがタップされた時の処理
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        // Cancelボタンを追加
        alertController.addAction(cancelButton)
        // アラートダイアログ表示
        present(alertController, animated: true, completion: nil)
    }
    // デーブル行ごとのセルを返却する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 利用可能なセルを取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        // 行番号にあったToDoの情報を取得
        let myTodo = todoList[indexPath.row]
        // セルのラベルにToDoのタイトルをセット
        cell.textLabel?.text = myTodo.todoTitle
        
        if myTodo.todoDone {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }else{
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        return cell
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             // todoListの配列長を返す
            return todoList.count
         }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myTodo = todoList[indexPath.row]
        // フラグを変更
        if myTodo.todoDone {
            myTodo.todoDone = false
        }else{
            myTodo.todoDone = true
        }
        // セルの状態を変更する
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        // データ保存、Data型にシリアライズ処理
        do{
            let data: Data = try NSKeyedArchiver.archivedData(withRootObject: todoList, requiringSecureCoding: true)
                let userDefaults = UserDefaults.standard
                userDefaults.set(data, forKey: "todoList")
                userDefaults.synchronize()
        }catch{
            print("エラー")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 削除処理可能かどうか
        if editingStyle == UITableViewCell.EditingStyle.delete{
            // ToDoリストから削除
            todoList.remove(at: indexPath.row)
            // セルを削除
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            // シリアライズ処理とデータの保存
            do{
                let data: Data = try NSKeyedArchiver.archivedData(withRootObject: todoList, requiringSecureCoding: true)
                let userDefaults = UserDefaults.standard
                userDefaults.set(data, forKey: "todoList")
                userDefaults.synchronize()
            }catch{
                print("エラー")
            }
        }
    }
    
}

class MyTodo: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    
    // Todoのタイトル
    var todoTitle: String?
    // todoが完了したかどうかのフラグ
    var todoDone: Bool = false
    
    // 引数なしのコンストラクタ
    override init(){
        
    }
    
    // シリアライズ処理
    func encode(with coder: NSCoder){
        coder.encode(todoTitle, forKey:"todoTitle")
        coder.encode(todoDone, forKey: "todoDone")
    }
    
    // デシリアライズ処理
    required init?(coder Decoder: NSCoder){
        todoTitle = Decoder.decodeObject(forKey: "todoTitle") as? String
        todoDone = Decoder.decodeBool(forKey: "todoDone")
    }
}
