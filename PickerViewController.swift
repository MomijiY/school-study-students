//
//  PickerViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/03/26.
//  Copyright © 2019 吉川椛. All rights reserved.
//

import UIKit


class PickerViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet var pickerView: UIPickerView!

    let dataList = [
        "数学", "国語", "英語", "理科", "社会",
        "音楽", "技術・家庭科", "保健・体育", "美術",
        "書道", "道徳", "聖書", "塾", "その他", "プログラミング"
    ]
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // ViewContorller 背景色
            self.view.backgroundColor = UIColor(red: 0.92, green: 1.0, blue: 0.94, alpha: 1.0)
            
            // PickerView のサイズと位置
            pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
            pickerView.backgroundColor = UIColor(red: 0.69, green: 0.93, blue: 0.9, alpha: 1.0)
            
            // PickerViewはスクリーンの中央に設定
            pickerView.center = self.view.center
            
            // Delegate設定
            pickerView.delegate = self
            pickerView.dataSource = self
            
            // Label 位置はPickerViewより150上に設定、高さを２行表示分とる
            let yPosition = pickerView.frame.origin.y
            label.frame = CGRect(x: 0, y: yPosition - 100, width: self.view.frame.width, height: 100)
            
            // ラベルを２行表示
            label.numberOfLines = 1
            label.text = "教科"
            // フォントサイズを大きく
            label.font = UIFont.systemFont(ofSize: 36)
            // テキストを中央寄せにする
            label.textAlignment = NSTextAlignment.center
            
            
            self.view.addSubview(pickerView)
            self.view.addSubview(label)
        }
        
        // UIPickerViewの列の数
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        // UIPickerViewの行数、リストの数
        func pickerView(_ pickerView: UIPickerView,
                        numberOfRowsInComponent component: Int) -> Int {
            return dataList.count
        }
        
        // UIPickerViewの最初の表示
        func pickerView(_ pickerView: UIPickerView,
                        titleForRow row: Int,
                        forComponent component: Int) -> String? {
            
            return dataList[row]
        }
        
        // UIPickerViewのRowが選択された時の挙動
        func pickerView(_ pickerView: UIPickerView,
                        didSelectRow row: Int,
                        inComponent component: Int) {
            
            label.text = dataList[row]
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
    }

        
    
    

