//
//  NotificationViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/06/15.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit
import Firebase

var oshirasenakami = [String]()

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oshirasenakami.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pastcell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "pastnotification", for: indexPath)
        
        pastcell.textLabel?.text = ntfLabel.text
        
        pastcell.textLabel?.numberOfLines=0
        
        return pastcell
    }
    
    
    var  database: Firestore!
    
    let saveData: UserDefaults = UserDefaults.standard
    
    
    
//    @IBOutlet weak var lookBtn: UIButton!
    
    @IBOutlet weak var ntfLabel: UILabel!
    
    @IBOutlet weak var kousinbtn: UIButton!
    
//    @IBOutlet weak var pastbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "pastnoti") != nil {
            oshirasenakami = UserDefaults.standard.object(forKey: "pastnoti") as! [String]
        }
        
        self.saveData.set(oshirasenakami, forKey: "pastnoti")
        
        oshirasenakami =  UserDefaults.standard.object(forKey: "pastnoti")  as! [String]
        
        database = Firestore.firestore()
    }
    
//    @IBAction func seepastntf() {
//
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }
//    
    //セルの編集許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
//    @IBAction func btnLook() {
//        let alert: UIAlertController = UIAlertController(title: "OK", message: "見ましたボタンを押す", preferredStyle: .alert)
//
//        alert.addAction(
//            UIAlertAction(title: "OK", style: .default, handler: {action in
//
//                self.navigationController?.popViewController(animated: true)
//            }
//            )
//        )
//        present(alert, animated: true, completion: nil)
//    }
    
    @IBAction func kousinBtn() {
        oshirasenakami.append(ntfLabel.text!)
        database.collection("teacher_data").document("noti").getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
                
            }
            guard let data = snap?.data() else { return }
            print(data["noti"]!)
            
            
            self.ntfLabel.text = data["noti"] as? String
        }
        //        //UITableView、numberOfRowsInSectionの追加(表示するcell数を決める)
        //        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //            //戻り値の設定(表示するcell数)
        //            return pastnotification.count
        //        }
        //
        //        //UITableView、cellForRowAtの追加(表示するcellの中身を決める)
        //        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //            let pastcell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "pastnotification", for: indexPath)
        //
        //            pastcell.textLabel?.text = ntfLabel.text
        //            pastcell.textLabel?.numberOfLines=0
        //
        //
        //            //入力したテキストを配列に格納
        //    r        pastnotification.append(ntfLabel.text!)
        //            //セルをリロード
        //            tableView.reloadData()
        //
        //
        //            database.collection("teacher_data").document("noti").getDocument { (snap, error) in
        //                if let error = error {
        //                    fatalError("\(error)")
        //
        //                }
        //                guard let data = snap?.data() else { return }
        //                print(data["noti"]!)
        //
        //
        //                self.ntfLabel.text = data["noti"] as? String
        //            }
        //            return pastcell
        //
        //        }
        
    }
    
}
