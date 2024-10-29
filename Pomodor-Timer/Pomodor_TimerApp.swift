//
//  Pomodor_TimerApp.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 24/10/24.
//

import SwiftUI

@main
struct Pomodor_TimerApp: App {
    @State private var timerModel = TimerModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(timerModel)
        }
    }
}
