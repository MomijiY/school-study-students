//
//  pastnotViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/08/10.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit

class pastnotViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
//UITableView、numberOfRowsInSectionの追加(表示するcell数を決める)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //戻り値の設定(表示するcell数)
        return oshirasenakami.count
    }

    //UITableView、cellForRowAtの追加(表示するcellの中身を決める)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //変数を作る
        let pastcell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "pastnotification", for: indexPath)
        //変数の中身を作る
        pastcell.textLabel!.text = oshirasenakami[indexPath.row]
        //戻り値の設定（表示する中身)
        return pastcell
    }

    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "pastnoti") != nil {
                   oshirasenakami = UserDefaults.standard.object(forKey: "pastnoti") as! [String]
               }
        
        
//        if UserDefaults.standard.object(forKey: "pastnoti") != nil {
//            pastnotification = UserDefaults.standard.object(forKey: "pastnoti") as! [String]
//        }

        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
