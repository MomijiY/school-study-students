//
//  testsViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/06/14.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit

class testsViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    var scrollView = UIScrollView()

    
    @IBOutlet weak var testdatefield: UITextField!

    @IBOutlet weak var testtitle: UILabel!

    @IBOutlet weak var backbtn: UIButton!

    @IBOutlet weak var mokuhyou1: UITextField!
    
    @IBOutlet weak var mokuhyou2: UITextField!

    @IBOutlet weak var mokuhyou3: UITextField!
        
    @IBOutlet weak var testnext: UIButton!

    var testdatePicker: UIDatePicker = UIDatePicker()
    var testdatePicker2: UIDatePicker = UIDatePicker()
    var saveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("test")
        
        self.scrollView.delegate = self
        self.scrollView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        // scrollViewを設置
        self.scrollView.addSubview(self.mokuhyou2)
        self.scrollView.addSubview(self.mokuhyou3)

        self.view.addSubview(self.scrollView)

        self.view.sendSubviewToBack(scrollView)


        testdatePicker.datePickerMode = UIDatePicker.Mode.date
        testdatePicker.timeZone = NSTimeZone.local
        testdatePicker.locale = Locale.current
        testdatefield.inputView = testdatePicker

        testdatePicker2.datePickerMode = UIDatePicker.Mode.date
        testdatePicker2.timeZone = NSTimeZone.local
        testdatePicker2.locale = Locale.current
        



        testdatefield.text = saveData.object(forKey: "testdate") as? String
        mokuhyou1.text = saveData.object(forKey: "title1") as? String
        mokuhyou2.text = saveData.object(forKey: "title2") as? String
        mokuhyou3.text = saveData.object(forKey: "title3") as? String
        // 決定バーの生成
        let toolbar_date = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar_date.setItems([spacelItem, doneItem], animated: true)



        testdatefield.inputView = testdatePicker
        testdatefield.inputAccessoryView = toolbar_date



        testdatefield.delegate = self

        mokuhyou1.delegate = self
        mokuhyou2.delegate = self
        mokuhyou3.delegate = self



        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))

        toolBar.barStyle = UIBarStyle.default

        toolBar.sizeToFit()

        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)

        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(testsViewController.commitButtonTapped))

        toolBar.items = [spacer, commitButton]


        // textfieldにplaceholderを設置
        self.mokuhyou1.placeholder = "目標１"
        self.mokuhyou2.placeholder = "目標２"
        self.mokuhyou3.placeholder = "目標３"
        self.testdatefield.placeholder = "テストの日程"


        // textfieldの枠を表示する.
        self.mokuhyou1.borderStyle = UITextField.BorderStyle.roundedRect
        self.mokuhyou2.borderStyle = UITextField.BorderStyle.roundedRect
        self.mokuhyou3.borderStyle = UITextField.BorderStyle.roundedRect


    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//
//
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }

    
    @objc func keyBoardWillHide(notification: Notification) {
        
        
    }
    
    
    
    
    @IBAction func testnextac(_ sender: Any) {

        saveData.set(testdatefield.text, forKey: "testdate")

        saveData.set(mokuhyou1.text, forKey: "title1")
        saveData.set(mokuhyou2.text, forKey: "title2")
        saveData.set(mokuhyou3.text, forKey: "title3")
    }

//    @objc func done_timer() {
//        testdatefield.endEditing(true)
//
//        let formtter = DateFormatter()
//
//        formtter.dateFormat = "yyyy年MM月dd日"
//
//        testdatefield.text = "\(formtter.string(from: testdatePicker.date))"
//    }

    @objc func done() {
        testdatefield.endEditing(true)

        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy年MM月dd日"

        testdatefield.text = "\(formatter.string(from: testdatePicker.date))"
    }

    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mokuhyou1.resignFirstResponder()
        mokuhyou2.resignFirstResponder()
        mokuhyou3.resignFirstResponder()
        
        return true
    }
    
    
    
//
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Notificationの発行
                self.configureObserver()
    }

//
    
    // Notificationを設定
    func configureObserver() {

        let notification = NotificationCenter.default

        notification.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        notification.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // Notificationを削除
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    var selectedTextField: UITextField?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedTextField = nil
    }
    
    // キーボードが現れたときにviewをずらす
    @objc func keyboardWillShow(notification: Notification?) {
        guard let selectedTextField = selectedTextField else { return }
        if selectedTextField == mokuhyou2 {
            let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration!) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            }
        }
        if selectedTextField == mokuhyou3 {
            let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration!) {
                self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
            }
        }
    }
    
    

    // キーボードが現れたときにviewをずらす
//    @objc func keyboardWillShow(notification: Notification?) {
//
//    }

    // キーボードが消えたときにviewを戻す
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform.identity
        }
    }



}
