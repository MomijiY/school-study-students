//
//  FirstViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/06/14.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit
import Firebase

class FirstViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate{
    
    var window: UIWindow?
    
    @IBOutlet weak var label:  UILabel!
    
    @IBOutlet weak var haikei: UILabel!
    
    
    
    @IBOutlet weak var daylabel: UILabel!
    
    
    
    @IBOutlet weak var userlabel: UILabel!
    
    @IBOutlet weak var newinfo: UIButton!
    
    @IBOutlet weak var kugire1: UILabel!
    
    @IBOutlet weak var todolist: UIButton!
    
    @IBOutlet weak var kugire2: UILabel!
    
    @IBOutlet weak var stymemory: UIButton!
    
    @IBOutlet weak var kugire3: UILabel!
    
    @IBOutlet weak var daytesbtn: UIButton!

    
    @IBOutlet weak var kugire4: UILabel!
    

    
    @IBOutlet weak var checkcomment: UIButton!
    
    
    

 
    
    
 
    
    
    
 
    
    
 
        
  
    func getToday(format:String = "dd") -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: now as Date)
    }
    
    var saveData: UserDefaults = UserDefaults.standard
 
    

    
    // ユーザー名
    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    let vc = UIViewController()
    // 遷移方法にフルスクリーンを指定
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true, completion: nil)
        
        
        
            self.navigationController?.navigationBar.isHidden = true
        
        label.frame = CGRect(x: 0, y: 30, width: self.view.frame.width, height: 150)
        label.textAlignment = NSTextAlignment.center
        
        label.numberOfLines = 2
        self.view.addSubview(label)
        
        let now = Date()
        
//        let decimal = 3.14
//        let decimal2 = decimal * 10
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        label.text = formatter.string(from: now)
        // Do any additional setup after loading the view.
        
        // ユーザー名を表示
        userlabel.text = userName
        
        // ユーザー名を表示
        if let userName = UserDefaults.standard.string(forKey: "userNameKey") {
            userlabel.text = "\(userName)さんこんにちは。"
        } else {
            userlabel.text = "読み込めなかった時"
        }
        
  
        
//        // UITextFieldの表示する位置を設定する.
//        self.mokuhyou1.frame = CGRect(x: 100,y: 700,width: 200,height: 30)
//        self.mokuhyou2.frame = CGRect(x: 100,y: 700,width: 200,height: 30)
//        self.mokuhyou3.frame = CGRect(x: 100,y: 700,width: 200,height: 30)
        
//        if userName == "" {
//
//                let _ = Auth.auth().addStateDidChangeListener() { ( auth, user) in
//                let storyboard:UIStoryboard = UIStoryboard(name: "Main",bundle:nil)
//                let viewController:UIViewController
//
//                if Auth.auth().currentUser != nil {
//                    viewController = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as UIViewController
//                } else {
//                    viewController = storyboard.instantiateViewController(withIdentifier: "main") as UIViewController
//                }
//                    self.window?.rootViewController = viewController
//                }
//        }
        // ルートはサインアップのViewController
        let rootVC = UINavigationController(rootViewController: UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() ?? UIViewController()
        )
        
        // サインアップ済みならホームのViewControllerを表示
        if UserDefaults.standard.bool(forKey: "appSignUpStatusKey") {
            rootVC.pushViewController(UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() ?? UIViewController(), animated: false)
        }
        
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        
        
//        let aDay = now
//        let bDay = Date(timeIntervalSince1970: TimeInterval((60*60*15) - 1)) // Jan 1, 1970 at 11:59 PM
//        let cDay = Date(timeIntervalSince1970: TimeInterval((60*60*39) - 1)) // Jan 2, 1970 at 11:59 PM
//
//        let diff1 = aDay.differenceInDay(bDay)
//        let diff2 = aDay.differenceInDay(cDay)
//
//        print(diff1) // -1
//        print(diff2) // 0
        
//        let myDateFormatter = DateFormatter()
//        myDateFormatter.dateFormat = "dd日"
//        let day1:Date = myDateFormatter.date(from: "")!
//        let day2:Date = myDateFormatter.date(from: "")!
//        let dayInterval = (Calendar.current.dateComponents([.day], from: day1, to: day2)).day
//        print(dayInterval!)
        
//        print("テストまであと\(floor(decimal2) / 10)日") // 3.1 (切り捨て)
//        testLabel.text = "テストまであと\(floor(decimal2) / 10)日"
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
//    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//        
//
//    }
//
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}


extension Date {
    func differenceInDay(_ date: Date) -> Int {
        let cal = Calendar(identifier: .gregorian)
        let lhs = cal.dateComponents([.year, .month, .day], from: self)
        let rhs = cal.dateComponents([.year, .month, .day], from: date)
        let components = cal.dateComponents([.day], from: lhs, to: rhs)
        return components.day!
    }
}
