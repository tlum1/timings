//
//  ViewController.swift
//  timings
//
//  Created by Денис Смолянинов on 02.07.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pausePlayButton: UIButton!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var isPaused = true
    var parser:TimeParser = TimeParser()
    
    @IBAction func startBtnClick(_ sender: Any) {
        print("start!")
        startBtn.alpha = 0
        clockLabel.alpha = 1
        pausePlayButton.alpha = 1
        stopButton.alpha = 1
        
        isPaused = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)

        
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
            self.count = 0
            self.timer.invalidate()
            self.clockLabel.text = self.parser.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startBtn.alpha = 1
            self.clockLabel.alpha = 0
            self.pausePlayButton.alpha = 0
            self.stopButton.alpha = 0
        }))
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    @objc func timerCounter() -> Void{
        count = count + 1
        let time = parser.secondsToHoursMinutesSeconds(seconds: count)
        let timeString = parser.makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        clockLabel.text = timeString
        
    }
    

    

}

