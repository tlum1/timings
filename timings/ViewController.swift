//
//  ViewController.swift
//  timings
//
//  Created by Денис Смолянинов on 02.07.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pausePlayButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
        textField.delegate = self
    }


    
    var timer:Timer = Timer()
    var count:Int = 0
    var isPaused = true
    var parser:TimeParser = TimeParser()
    var task:Task = Task()
    @IBAction func startBtnClick(_ sender: Any) {
        print("start!")
        startBtn.alpha = 0
        clockLabel.alpha = 1
        pausePlayButton.alpha = 1
        stopButton.alpha = 1
        
        isPaused = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
        textField.resignFirstResponder()
        if let text  = textField.text{
            task.name = text
        }
        titleLabel.text = task.name
        textField.alpha = 0
        
    }
    
    
    @IBAction func pausePlayButtonClick(_ sender: Any) {
        
        if isPaused{
            pausePlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }else{
            pausePlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer.invalidate()
        }
        isPaused = !isPaused
    }
    
    
    @IBAction func stopButtonClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Stop timer?", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: {(_) in
            // do nothing
        }))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: {(_) in
            let time = self.parser.secondsToHoursMinutesSeconds(seconds: self.count)
            let timeString = self.parser.makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
            self.task.time = timeString
            self.task.writeTask(path: "statistic")
            self.count = 0
            self.timer.invalidate()
            self.clockLabel.text = self.parser.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startBtn.alpha = 1
            self.clockLabel.alpha = 0
            self.pausePlayButton.alpha = 0
            self.stopButton.alpha = 0
            self.textField.alpha = 1
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    @objc func timerCounter() -> Void{
        count = count + 1
        let time = parser.secondsToHoursMinutesSeconds(seconds: count)
        let timeString = parser.makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        
    }
    

    @IBAction func textFieldActive(_ sender: Any) {
        
        
    }
    

}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        if let text  = textField.text{
            self.task.name = text
        }
        return true
    }
}
