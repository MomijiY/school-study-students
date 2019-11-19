//
//  RemindViewController.swift
//  timer3
//
//  Created by 吉川椛 on 2019/03/25.
//  Copyright © 2019 吉川椛. All rights reserved.
//


import UIKit
import AVFoundation
import Firebase
import AudioToolbox

class RemindViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    
    
    var timerPicker: UIDatePicker = UIDatePicker()
    var vibration: Bool = false
    
//    var timer_count: Float = 30   //timer
    var timer = Timer()           //stopwatch
    var timer_timer = Timer()
    
    var database: Firestore!
    
    var saveData: UserDefaults = UserDefaults.standard
    
    var count: Float = 0.0
    
    @IBOutlet weak var dateField: UITextField!
//    @IBOutlet weak var timerField: UITextField! //
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var timerpicker: UIDatePicker!
    
//    var timerpicker: UIDatePicker = UIDatePicker() //
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    
    @objc func done() {
        dateField.endEditing(true)
        
        
        let formatter = DateFormatter()
        
        
        formatter.dateFormat = "h時間m分"
        
        
        dateField.text = "\(formatter.string(from: datePicker.date))"
        
        
        
    }
    
    @objc func done_timer() {
        timerLabel.endEditing(true)
        
        let formtter = DateFormatter()
        
        formtter.dateFormat = "HH時間mm分ss秒"
        
        timerLabel.text = "\(formtter.string(from: timerPicker.date))"
    }
    
    
    @IBAction func saveMemo() {
        print(dateField.text!)
        
        saveData.set(dateField.text, forKey: "Text")
        saveData.set(manualfield.text, forKey: "Page")
        saveData.set(manuallabel3.text, forKey: "Subject")
        saveData.set(labelStopwatch.text, forKey: "Stopwatch")
        saveData.set(timerLabel.text, forKey: "Timer")
//        dateField.text = timerLabel.text
        
        let alert: UIAlertController = UIAlertController(title: "OK", message: "記録の保存が完了しました", preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: { action in
                
                self.navigationController?.popViewController(animated: true)
            }
            )
        )
        present(alert, animated: true, completion: nil)
        
        let data = [
            "text": dateField.text!,
            "page": manualfield.text!,
            "subject": manuallabel3.text!
            ] as [String: Any]
        
        database.collection("data").document("example").setData(data){err in
            if let err = err {
                print("Error writiing document: \(err)")
            }else {
                print("Document successfully wriitten!")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return  true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //スクリーンサイズの取得
    let screenSize = UIScreen.main.bounds.size
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    var printingImage: UIImage?
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    
    
    @IBOutlet var pickerView: UIPickerView! //科目のpicker
    
    var dataList = [
        "数学", "国語", "英語", "理科", "社会",
        "音楽", "技術・家庭科", "保健・体育", "美術",
        "書道", "道徳", "聖書", "塾", "その他", "プログラミング",
        ]
    
    
    var audioPlayer: AVAudioPlayer!
    
    func setAudioPlayer(soundName: String, type: String) {
        
        let soundFilePath = Bundle.main.path(forResource: soundName, ofType: type)!
        let fileURL = URL(fileURLWithPath: soundFilePath)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("音楽ファイルが読み込めませんでした")
        }
        
    }
    
    
    
    
    //timer
    @IBAction func startbutton(_ sender: Any) { //timer start button
        timer_time = Int(timerpicker.countDownDuration)
        timerLabel.text = "\(timer_time / 3600) : \(timer_time / 60 % 60) : \(timer_time % 60)"
        timer_timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)

    }
    

    
    func startVibrateInterval() {
        // どのバイブレーションを鳴らすか
        let systemSoundID = SystemSoundID(kSystemSoundID_Vibrate)
//        // 繰り返し用のコールバックをセット
//        AudioServicesAddSystemSoundCompletion(systemSoundID, nil, nil, { (systemSoundID, nil) -> Void in


            if timer_time == 0 {
                // 繰り返し再生
                AudioServicesPlaySystemSound(systemSoundID)
            } else  {
//                // コールバックを解除
                AudioServicesRemoveSystemSoundCompletion(systemSoundID)
            }

//        }, nil)

        // 初回のバイブレーションを鳴らす
        AudioServicesPlaySystemSound(systemSoundID)

    }
    
    
    
    @objc func countDown() {
        if(timer_time > 0){
            timer_time -= 1
            timerLabel.text = "\(timer_time / 3600) : \(timer_time / 60 % 60) : \(timer_time % 60)"
        }else{
            print("---")
//            let alert: UIAlertController = UIAlertController(title: "終了", message: "タイマーが終了しました", preferredStyle: .alert)
//            alert.addAction(
//                UIAlertAction(
//                    title: "止める",
//                    style: .default,
//                    handler: { action in
//                        //ボタンが押された時の動作
//                        self.vibration = false
//                        print("ストップボタンが押された")
//                }
//                )
//            )
//            present(alert, animated: true, completion: nil)
            
            let alert: UIAlertController = UIAlertController(
                title: "タイマーを止める",
                message: "タイマーが終了しました。",
                preferredStyle: .alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { action in
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                        print("OKbutton")
                }
                )
            )
            present(alert, animated: true, completion: nil)
            
//            AudioServicesPlaySystemSound( kSystemSoundID_Vibrate )
            vibration = true
            startVibrateInterval()
            timer_timer.invalidate()
            
        }
    }
    
    @IBAction func stopbtn(_ sender: Any) {
        if timer_timer.isValid == true  {
            timer_timer.invalidate()
            //
            timerLabel.endEditing(true)
            
            timerLabel.text = "00:00:00"
        }
    }
    //timer
    
    @IBOutlet weak var scSegment: UISegmentedControl!  //セグメントコントロール
    
    //    var stopwatchtimer = Timer()                 // Timerクラス
    var startTime: TimeInterval = 0     // Startボタンを押した時刻
    var elapsedTime: Double = 0.0       // Stopボタンを押した時点で経過していた時間
    var time : Double = 0.0             // ラベルに表示する時間(stopwatch)
//    var timer_time : Double = 0.0       //ラベルに表示する時間(timer)
    var timer_time:Int!
    @IBOutlet weak var labelStopwatch: UILabel!     // タイムを表示するラベル
    
    @IBOutlet weak var buttonStart: UIButton!   // Startボタン
    @IBOutlet weak var buttonStop: UIButton!    // Stopボタン
    @IBOutlet weak var buttonReset: UIButton!   // Resetボタン
    
    
    // Startボタンを押した時の処理(stopwatch)
    @IBAction func tapStart() {
        buttonStart.isEnabled = false
//        buttonReset.isEnabled = false
//
        buttonStop.isEnabled = true
        
        startTime = Date().timeIntervalSince1970
        // 0.01秒おきに関数「update」を呼び出す
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        buttonStart.layer.cornerRadius = 10
    }
    
    // 0.01秒ごとに呼び出される処理
    @objc func update() {
        // 経過時間は以下の式で計算する
        // (現在の時刻 - Startボタンを押した時刻) + Stopボタンを押した時点で経過していた時刻
        time = Date().timeIntervalSince1970 - startTime + elapsedTime
        // 時間を小数点前後で分割(小数点以下は2桁だけ取得)
        let sec = Int(time)
        
        // 「XX:XX:XX」形式でラベルに表示する
        let displayStr = NSString(format: "%2d:%02d:%02d", sec/3600, (sec/60)%60, sec%60) as String
        labelStopwatch.text = displayStr
    }
    
    // Stopボタンを押した時の処理
    @IBAction func tapStop() {
        // タイマー処理を止める
        timer.invalidate()
        
        buttonStop.layer.cornerRadius = 10
        
        // Startボタン、Resetボタンを有効化
        buttonStart.isEnabled = true
        buttonReset.isEnabled = true
        // Stopボタンを無効化
        buttonStop.isEnabled = false
        
        // 再度Startボタンを押した時に加算するため、これまでに計測した経過時間を保存
        elapsedTime = time
        
    }
    
    // Resetボタンを押した時の処理
    @IBAction func tapReset() {
        timer.invalidate()
        buttonReset.layer.cornerRadius = 100
        // 経過時間、ラベルを初期化する
        elapsedTime = 0.0
//        labelStopwatch.text = "00:00:00"
        dateField.text = labelStopwatch.text
        
        buttonStop.layer.cornerRadius = 10
        
        // Startボタン、Resetボタンを有効化
        buttonStart.isEnabled = true
        buttonStop.isEnabled = true
        // Stopボタンを無効化
        buttonReset.isEnabled = false
        
        // 再度Startボタンを押した時に加算するため、これまでに計測した経過時間を保存
        elapsedTime = time
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    
    //    シェアボタン
    //    @IBAction func showActivityView() {
    //        let activityItems: Array<Any> = ["aaa"]
    //
    //        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    //
    //        let excludedActivityTypes: Array<UIActivity.ActivityType> = [
    //
    //            UIActivity.ActivityType.postToFlickr,
    //            UIActivity.ActivityType.postToTencentWeibo
    //        ]
    //        activityViewController.excludedActivityTypes = excludedActivityTypes
    //
    //        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, activityError: Error?) in
    //
    //            guard completed else {return}
    //
    //            switch activityType {
    //            case UIActivity.ActivityType.postToTwitter:
    //                print("Tweeted")
    //            case UIActivity.ActivityType.print:
    //                print("Printed")
    //            case UIActivity.ActivityType.saveToCameraRoll:
    //                print("Saved to Camera Roll")
    //            default:
    //                print("Done")
    //            }
    //        }
    //
    //        self.present(activityViewController, animated: true, completion: nil)
    //    }
    //    シェアボタン
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIViewController()
        // 遷移方法にフルスクリーンを指定
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        

        
        timerLabel.text = "00:00:00"
        
//        //
//        timerPicker.datePickerMode = UIDatePicker.Mode.countDownTimer
//        timerPicker.timeZone = NSTimeZone.local
//        timerPicker.locale = Locale.current
//        timerField.inputView = timerPicker
//
//        let toolbar_timer = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelitem_timer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneitem_timer = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done_timer))
//        toolbar_timer.setItems([spacelitem_timer, doneitem_timer], animated: true)
//
//        timerField.inputView = timerPicker
//        timerField.inputAccessoryView = toolbar_timer
        //
        
//        //timer picker
//        timerpicker.datePickerMode = UIDatePicker.Mode.countDownTimer
//        timerpicker.timeZone = NSTimeZone.local
//        timerpicker.locale = Locale.current
//        timerField.inputView = timerpicker
//        //timer インプットビュー設定
//        timerField.inputView = timerpicker
//        //
//        timerField.text = saveData.object(forKey: "timer") as? String
        
        
        database = Firestore.firestore()
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.countDownTimer
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateField.inputView = datePicker
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        // インプットビュー設定(紐づいているUITextfieldへ代入)
        dateField.inputView = datePicker
        dateField.inputAccessoryView = toolbar
        
        dateField.text = saveData.object(forKey: "Text") as? String
        manuallabel3.text = saveData.object(forKey: "Subject") as? String
        manualfield.text = saveData.object(forKey: "Page") as? String
        timerLabel.text = saveData.object(forKey: "Timer") as? String
        //manual・ページ数入力の時のキーボードの種類ー＞数字のみ
        manualfield.keyboardType = UIKeyboardType.numberPad
        
        //
        func textFieldDidBeginEditing(_ textField: UITextField) {
            manualfield.text = ""
        }
        
        // PickerView のサイズと位置
        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        
        
        // PickerViewはスクリーンの中央に設定
        pickerView.center = self.view.center
        
        // Delegate設定
        pickerView.delegate = self
        pickerView.dataSource = self
        
        dateField.isHidden = false
        reset.isHidden = true
        start.isHidden = true
        stop.isHidden = true
        timerstart.isHidden = true
        timerstop.isHidden = true
        //        timerlabel.isHidden = true
        labelStopwatch.isHidden = true
        teisyutubutton.isHidden = false
        timerpicker.isHidden = true
        timerLabel.isHidden = true
//        timerDoneOU.isHidden = true
        
    }
    
    //manual・ページ数入力の時キーボードをしまう方法ー＞text field 以外の部分をタッチ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var reset: UIButton!               //ストップウォッチ（リセット）
    @IBOutlet weak var start: UIButton!               //ストップウォッチ（スタート）
    @IBOutlet weak var stop: UIButton!                //ストップウォッチ（ストップ）
    @IBOutlet weak var timerstart: UIButton!          //タイマー（スタート）
    @IBOutlet weak var timerstop: UIButton!           //タイマー（ストップ）
    //    @IBOutlet weak var timerlabel: UILabel!           //タイマー（label）
    @IBOutlet weak var manuallabel: UILabel!          //手動入力(ページ数)
    @IBOutlet weak var manualfield: UITextField!      //手動入力(ページ数のtext field)
    @IBOutlet weak var teisyutubutton: UIButton!      //提出ボタン
    @IBOutlet weak var studytime: UILabel!

    @IBAction func resetbutton(_ sender: Any) {   //ストップウォッチ
    }
    
    @IBAction func startbutton1(_ sender: Any) {   //ストップウォッチ
    }
    
    @IBAction func stopbutton2(_ sender: Any) {    //ストップウォッチ
    }
    
//    @IBAction func StartButton(_ sender: Any) {   //タイマー
//        
//    }
//    
//    @IBAction func StopButton(_ sender: Any) {    //タイマー
//    }
//    
    
    @IBOutlet weak var manualsublabel: UILabel!        //教科を表示するラベル（pickerに対応するラベル）
    
//    @IBAction func timerDone() {
//        timerstart.isEnabled = true
//        timerstop.isEnabled = false
//        timerDoneOU.isEnabled = false
//
//        timerDoneOU.layer.cornerRadius = 100
//        timer.invalidate()
//        // 経過時間、ラベルを初期化する
//        elapsedTime = 0.0
//        timerLabel.text = "00:00:00"
//    }
//
    
    @IBAction func manualfield(_ sender: Any) {     //ページ数のfield
        manualfield.text = "\(String(describing: manualfield.text!))"
    }
    
    @IBOutlet weak var manuallabel1: UILabel!   //ページ数
    
    
    @IBOutlet weak var manuallabel3: UILabel!  //科目pickerに対応させるlabel
    
    @IBOutlet weak var manualpicker2: UIPickerView!  //科目picker
    
    @IBAction func teisyutubutton(_ sender: Any) {   //提出ボタン
    }
    
    //    @IBAction func timerpicker(_ sender: UIDatePicker) {
    //        let timerformatter = DateFormatter()
    //        timerformatter.dateFormat = "hh:mm:ss"
    //
    //
    //
    //        timerlabel.text = timerformatter.string(from: sender.date)
    ////        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    //    }
    
    @objc func updateTimer() {
        // 時間を小数点前後で分割(小数点以下は2桁だけ取得)
        let sec = Int(timer_time)
        
        timer_time = timer_time - 1
        if timer_time == Int(0.0) {
            timer.invalidate()
            timerpicker.isHidden = false
            timerLabel.isHidden = true
        } else {
            timerLabel.text = String(format: "%2d:%02d:%02d", sec/3600, (sec/60)%60, sec%60)
            timerpicker.isHidden = true
            timerLabel.isHidden = false
            
        }
        // 経過時間は以下の式で計算する
        // (現在の時刻 - Startボタンを押した時刻) + Stopボタンを押した時点で経過していた時刻
        timer_time = Int(Date().timeIntervalSince1970 - startTime + elapsedTime)
        
        
        // 「XX:XX:XX」形式でラベルに表示する
        let displayStr2 = NSString(format: "%2d:%02d:%02d", sec/3600, (sec/60)%60, sec%60) as String
        timerLabel.text = displayStr2
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        let vc = UIViewController()
//        // 遷移方法にフルスクリーンを指定
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
//    }

    
    

    
    //    @objc func updateTimer() {
    //
    //        let hours = Int(timer_time) / 3600
    //        let minutes = Int(timer_time) / 60 % 60
    //        let seconds = Int(timer_time) % 60
    //
    //        count = count - 1
    //
    //        if count == 0.0 {
    //            timer.invalidate()
    //            timepicker.isHidden = false
    //            timerlabel.isHidden = true
    //        } else {
    //            timerlabel.text = String(format: "%2d:%02d:%02d", hours,minutes,seconds)
    //            timepicker.isHidden = true
    //            timerlabel.isHidden = false
    //
    //        }
    
    
    //        if timepicker.countDownDuration == 60  {
    //            timer.invalidate()
    //
    //            setAudioPlayer(soundName: "Aleart", type: "mp3")
    //            audioPlayer.play()
    //
    //        } else {
    //            timepicker.setDate(timepicker.date - 1, animated: true)
    //        }
    //
    //        func timeString(time:TimeInterval) -> String {
    //
    //            let hours = Int(time) / 3600
    //            let minutes = Int(time) / 60 % 60
    //            let seconds = Int(time) % 60
    //
    //            return String(format: "%2d:%02d:%02d", hours,minutes,seconds)
    //
    //        }
    
    
    
    
    
    
    @IBAction func segmentButton() {
        
        
        switch scSegment.selectedSegmentIndex {
        case 0:
            
            reset.isHidden = true
            start.isHidden = true
            stop.isHidden = true
            timerstart.isHidden = true
            timerstop.isHidden = true
            //            timerlabel.isHidden = true
            labelStopwatch.isHidden  = true
            dateField.isHidden = false
            manuallabel.isHidden = true
            manualfield.isHidden = false
            manualpicker2.isHidden = false
            manuallabel1.isHidden = false
            manuallabel3.isHidden = false
            //
            timerLabel.isHidden = true
            
            teisyutubutton.isHidden = false
            timerpicker.isHidden = true
            studytime.isHidden = false
//            timerDoneOU.isHidden = true
            
            
        case 1:
            
            reset.isHidden = false
            start.isHidden = false
            stop.isHidden = false
            timerstart.isHidden = true
            timerstop.isHidden = true
            labelStopwatch.isHidden = false
            //            timerlabel.isHidden = true
            dateField.isHidden = true
            manuallabel.isHidden = true
            manualfield.isHidden = true
            manualpicker2.isHidden = true
            manuallabel1.isHidden = true
            manuallabel3.isHidden = true
            teisyutubutton.isHidden = false
            //
            timerLabel.isHidden = true
            timerpicker.isHidden = true
            studytime.isHidden = true
//            timerDoneOU.isHidden = true
            
        case 2:
            
            reset.isHidden = true
            start.isHidden = true
            stop.isHidden = true
            timerstart.isHidden = false
            timerstop.isHidden = false
            labelStopwatch.isHidden = true
            //            timerlabel.isHidden = true
            dateField.isHidden = true
            manuallabel.isHidden = true
            manualfield.isHidden = true
            manualpicker2.isHidden = true
            manuallabel1.isHidden = true
            manuallabel3.isHidden = true
            //
            timerLabel.text = "00:00:00"
            timerLabel.isHidden = false
            teisyutubutton.isHidden = false
            timerpicker.isHidden = false
            studytime.isHidden = true
//            timerDoneOU.isHidden = false
            
            
        default: break
            
        }
        
        
        
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        manuallabel3.text = dataList[row]
    }
}
