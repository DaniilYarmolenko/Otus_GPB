//
//  ViewController.swift
//  TimerBase_GPB
//
//  Created by Даниил Ярмоленко on 06.10.2022.
//

import UIKit

class ViewController: UIViewController {

    static let shared = ViewController()
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var timerIsStarted: Bool = false
    var timer: Timer? = nil
    var time = 0
    @IBAction func resetButtonAction(_ sender: UIButton) {
        resetTime()
    }
    @IBAction func startButtonAction(_ sender: UIButton) {
        timerIsStarted = true
        startTimer()
    }
    
    @IBAction func stopButtonAction(_ sender: UIButton) {
        timerIsStarted = false
        stopTimer()
    }
    
    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(timerForegrounObserverMethod), name:UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(timerBackgroundObserverMethod), name:UIApplication.willResignActiveNotification, object: nil)
        super.viewDidLoad()
        stopButton?.isEnabled = false
        resetButton?.isEnabled = false
        // Do any additional setup after loading the view.
    }
}
extension ViewController {
    
    // -MARK: Создаем таймер и добавляем его в runloop
    func createTimer(){
        let timer = Timer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        self.timer = timer
    }
    // -MARK: Удаляем таймер
    func cancelTimer(){
        timer?.invalidate()
        timer = nil
    }
    // -MARK: Обновляем значение переменной времени
    @objc func updateTimer() {
        self.time += 1
        updateTimeLabel()
    }
    // -MARK: Обнуляем таймер
    func resetTime() {
        stopTimer()
        resetButton?.isEnabled = false
        self.time = 0
        updateTimeLabel()
    }
    // -MARK: запускаем таймер
    func startTimer() {
        resetButton?.isEnabled = true
        if timer == nil {
            createTimer()
            startButton?.isEnabled = false
            stopButton?.isEnabled = true
        } else {
            cancelTimer()
        }
        
    }
    // -MARK: останавливаем таймер
    func stopTimer() {
        startButton?.isEnabled = true
        stopButton?.isEnabled = false
        cancelTimer()
    }
    // -MARK: обновляем label
    func updateTimeLabel() {
        let minutes = Int(self.time) / 60
        let seconds = Int(self.time) % 60
        
        var times: [String] = []
        switch minutes {
        case 0...9:
            times.append("0\(minutes)")
        case 10...99:
            times.append("\(minutes)")
        default:
            timeLabel?.text = "Время вышло"
            resetTime()
            return
        }
        switch seconds {
        case 0...9:
            times.append("0\(seconds)")
        case 10...59:
            times.append("\(seconds)")
        default:
            return
        }
        timeLabel?.text = times.joined(separator: ":")
        
    }
    // -MARK: метод учета background
    @objc func timerBackgroundObserverMethod() {
        stopTimer()
    }
    // -MARK: метод учета перехода в foregound
    @objc func timerForegrounObserverMethod() {
        if time != 0 && timerIsStarted {
            startTimer()
        }
    }
}

