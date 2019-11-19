//
//  ViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/02/11.
//  Copyright © 2019 吉川椛. All rights reserved.
//

//  AddController.swift
import UIKit

//classの継承を追加
class ViewController: UIViewController{
    
    //テキストフィールドの設定
    @IBOutlet weak var TodoTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    // アイテムの型
    class Item {
        var title : String
        var done: Bool = false
        
        init(title: String) {
            self.title = title
        }
    }
    // この配列に作ったアイテムを追加していく
    var itemArray: [Item] = []
    
    var todoKobetsunonakami = [String]()
    
    //最初からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        // if let の意味がなかったので修正
        //追加画面で入力した内容を取得する
        if let todos = UserDefaults.standard.object(forKey: "TodoList") as? [String] {
            todoKobetsunonakami = todos
        }
    }
    
    //最初からあるコード
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
    
    //追加ボタンの設定
    @IBAction func TodoAddButten(_ sender: Any) {
        //変数に入力内容を入れる
        todoKobetsunonakami.append("Todo\(todoKobetsunonakami.count)")
        
        //追加ボタンを押したらフィールドを空にする
        TodoTextField.text = ""
        
        //変数の中身をUDに追加
        UserDefaults.standard.set(todoKobetsunonakami, forKey: "TodoList" )
        
        // tableViewのリロードがなかった
        tableView.reloadData()
    }
    
    //cancelボタンの設定
    @IBAction func CancelButton(_ sender: Any) {
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //UITableView、numberOfRowsInSectionの追加(表示するcell数を決める)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //戻り値の設定(表示するcell数)
        return todoKobetsunonakami.count
    }
    
    // チェックマークの処理
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let Cell = tableView.cellForRow(at: indexPath)

           Cell?.accessoryType = .checkmark
        
       }


       // チェックマークの処理
       func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
           let Cell = tableView.cellForRow(at: indexPath)

           Cell?.accessoryType = .none
        
       }
    
    //UITableView、cellForRowAtの追加(表示するcellの中身を決める)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //変数を作る
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        //変数の中身を作る
        TodoCell.textLabel?.text = todoKobetsunonakami[indexPath.row]
        
        let Cell = tableView.cellForRow(at: indexPath)

        Cell?.accessoryType = .checkmark
        
        //戻り値の設定（表示する中身)
        return TodoCell
    }
    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            //itemArray.remove(at: indexPath.row)
            todoKobetsunonakami.remove(at: indexPath.row)
            
            // todokebetsunonakamiが更新されたので保存
            UserDefaults.standard.set(todoKobetsunonakami, forKey: "TodoList" )
            
            
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
