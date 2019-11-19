//
//  TodoViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/07/10.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit

//classの継承を追加
class TodoViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var todoTableViewCell: UITableViewCell!
    
    //UITableView、numberOfRowsInSectionの追加(表示するcell数を決める)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //戻り値の設定(表示するcell数)
        return TodoKobetsunonakami.count
    }
    
    //UITableView、cellForRowAtの追加(表示するcellの中身を決める)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //変数を作る
        let TodoCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        //変数の中身を作る
        TodoCell.textLabel!.text = TodoKobetsunonakami[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cells", for: indexPath) // Storyboard上のテーブルセルのIdentifierと一致
        cell.textLabel!.text = display[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator // ここで「>」ボタンを設定
        
        //戻り値の設定（表示する中身)
        return TodoCell
    }
    
    let display:Array = ["cell1", "cell2", "cell3"]
    
    
    //最初からあるコード
    override func viewDidLoad() {
        super.viewDidLoad()
        //追加画面で入力した内容を取得する
        if UserDefaults.standard.object(forKey: "TodoList") != nil {
            TodoKobetsunonakami = UserDefaults.standard.object(forKey: "TodoList") as! [String]
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
}

