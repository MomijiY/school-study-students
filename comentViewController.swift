//
//  comentViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/06/22.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit
import Firebase

class comentViewController: UIViewController {
    var database: Firestore!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    @IBOutlet weak var comentLbl: UILabel!
    
    @IBOutlet weak var reroadbtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        database = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func reroadbtnAc() {
        database.collection("coment").document("coment").getDocument { (snap, error) in
            if let error = error {
                fatalError("\(error)")
                
            }
            guard let data = snap?.data() else { return }
            print(data["text"]!)
            
            self.comentLbl.text = data["text"] as? String
        }
        comentLbl.text = saveData.object(forKey: "coment") as? String
        saveData.set(comentLbl.text, forKey: "coment")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
