//
//  TimerModel.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 25/10/24.
//

import Foundation
import SwiftUI
import Combine
import UserNotifications

@MainActor
@Observable
class TimerModel {
    var hours: Int
    var minutes: Int
    var seconds: Int
    //var timer: Timer.TimerPublisher
    var isStopped = true
    var isRunning = false
    var isFinished = false
    var timeString: String
    var secondsElapsed: Int = 0
    var totalSecondsSet: Int
    private var timerCancellable: AnyCancellable?
    
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 1) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
        timeString = "00:01"
        totalSecondsSet = 1
        
    }
    
    func startTimer() {
        requestNotificationDelivery()
        let totalSeconds = (hours * 3600) + (minutes * 60) + (seconds)
        self.secondsElapsed = 0
        self.totalSecondsSet = totalSeconds
        timeString = getTimeString()
        self.isStopped = false
        self.isFinished = false
        self.isRunning = true
        timerCancellable = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: {[weak self] _ in
                self?.updateTimer()
            })
        scheduleNotification()
    }
    
    func updateTimer() {
        secondsElapsed += 1
        if secondsElapsed == totalSecondsSet {
            timeString = getTimeString()
            stopTimer()
        }
        else {
            timeString = getTimeString()
        }
    }
    
    func resetTimerUI() {
        timeString = "00:01"
        totalSecondsSet = 1
        secondsElapsed = 0
    }
    
    func stopTimer() {
        hours = 0
        minutes = 0
        seconds = 1
        self.isStopped = true
        //alert view depends on isFinished parameter.
        if secondsElapsed == totalSecondsSet {
            self.isFinished = true
        }
        self.isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private func requestNotificationDelivery() {
        let center = UNUserNotificationCenter.current()
        Task {
            do {
                try await center.requestAuthorization(options: [.alert, .sound])
            }
            catch {
                print("not granted authorization: \(error.localizedDescription)")
            }
        }
        
    }
    
    private func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodore Timer"
        content.body = "Hooray!!!! You Finished"
        let triggerCondition = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totalSecondsSet), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: triggerCondition)
        Task {
            do {
                try await UNUserNotificationCenter.current().add(request)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    // gets the number of seconds left till the end of timer and returns a string that displays the number of seconds reminaing as 00:00:00 with hours: minutes: seconds respectively
    private func getTimeString() -> String {
        let secondsRemaining = totalSecondsSet - secondsElapsed //pretend it is 10_700 seconds remaining
        var timeRemainingString  = ""
        let numberOfHours = Int(floor( Double(secondsRemaining) / Double(3600) )) // so num of hours is 2
        
        // HOURS CALCULATION SECTION
        if numberOfHours == 0 {
            timeRemainingString += ""
        }
        else {
            if numberOfHours >= 10 {
                timeRemainingString += "\(numberOfHours):"
            }
            else {
                timeRemainingString += "0\(numberOfHours):"
            }
        }
        
        /************************/
        //MINUTES CALCULATION SECTION
        let numerator = Double(secondsRemaining - (numberOfHours * 3600)) // 10,700 - 7,200
        let numberOfMinutes = Int( floor(numerator / Double(60) ) )
        if numberOfMinutes >= 10 {
            timeRemainingString += "\(numberOfMinutes):"
        }
        else {
            timeRemainingString += "0\(numberOfMinutes):"
        }
        
        /************************/
        //SECONDS CALCULATION SECTION
        let numberOfSeconds = Int(numerator) % 60
        if numberOfSeconds >= 10 {
            timeRemainingString += "\(numberOfSeconds)"
        }
        else {
            timeRemainingString += "0\(numberOfSeconds)"
        }
        return timeRemainingString
    }
    
}
