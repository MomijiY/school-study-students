//
//  AccountViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/07/14.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountViewController: UIViewController, UITextFieldDelegate  {
    var acount: FirebaseApp!
    
    var database: Firestore!
    
    var saveData: UserDefaults = UserDefaults.standard

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var groupnameTextField: UITextField!
    
    // AccountViewControllerの想定です
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Firestore.firestore()
        
        self.navigationController?.navigationBar.isHidden = true

        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.groupnameTextField.delegate = self

    }
    
    private func showErrorIfNeeded(_ errorOrNil: Error?) {
        // エラーがなければ何もしません
        guard let error = errorOrNil else { return }
        let message = "エラーが起きました" // ここは後述しますが、とりあえず固定文字列
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    var isFirst = true // 最初の処理かどうか
    
    
    @IBAction private func didTapSignUpButton() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let groupname = groupnameTextField.text ?? ""

        // ここに追加
        database.collection("group")
            .document("groupname")
            .getDocument { [weak self] (documentSnapshot, error) in
                guard let self = self else { return }

                if let error = error {
                    print(error)
                }

                // ドキュメントの内容を取り出す
        if let data = documentSnapshot?.data() {
                    // 強制キャストにしました
                    let storedGroupName = data["groupname"] as! String
                    let storedGroupPassword = data["grouppassword"] as! String

                    // Firestore側のデータとテキストフィールドの値を比較
                    if groupname == storedGroupName && password == storedGroupPassword {
                        // Authの処理
                        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                            guard let self = self else { return }
                            if let user = result?.user {
                                                let req = user.createProfileChangeRequest()
                                                req.displayName = name
                                                req.commitChanges() { [weak self] error in
                                                    guard let self = self else { return }
                                                    if error == nil {
                                                        user.sendEmailVerification() { [weak self] error in
                                                            guard let self = self else { return }
                                                            if error == nil {
                                                                // 仮登録完了画面へ遷移する処理
                                                                // サインアップ完了のフラグを保持する
                                                                UserDefaults.standard.set(true, forKey: "appSignUpStatusKey")
                                                                UserDefaults.standard.synchronize()
                                                            }
                                                            self.showErrorIfNeeded(error)
                                                        }
                                                    }
                                                    self.showErrorIfNeeded(error)
                                                }
                                            }
                                            self.showErrorIfNeeded(error)
                            //            else {
                            //                // Firestore側のgroupNameとgroupPasswordが一致しない時の処理
                            //            }
                                                // サインアップ完了のフラグを保持する
                                                UserDefaults.standard.set(true, forKey: "appSignUpStatusKey")
                                                // ユーザー名を保存する
                                                UserDefaults.standard.set(name, forKey: "userNameKey")
                                                UserDefaults.standard.synchronize()
                                        if (email == "" || password == "" || name == "" || groupname == "") {
                                            let message = "全てのフォームに記入して下さい。"
                                            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                            self.present(alert, animated: true, completion: nil)
                                        }
                                    }
                        }
                    }
                }
        }
    }
                
//        database.collection("group").document("groupname").getDocument { (snap, error) in
//            if let error = error {
//                fatalError("\(error)")
//
//            }
//            guard let data = snap?.data() else { return }
//            print(data["group"]!)
//
//            self.comentLbl.text = data["text"] as? String
//        }
//        comentLbl.text = saveData.object(forKey: "coment") as? String
//        saveData.set(comentLbl.text, forKey: "coment")
        
        
        


    




    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


