//
//  TimerButtonView.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 25/10/24.
//

import SwiftUI
import UserNotifications

struct TimerButtonView: View {
    @Binding var isPresentedView: Bool
    @Environment(TimerModel.self) private var timerModel
    
    var body: some View {
        Button {
            //bring up timer setup view
            // dont schedule notification if you stop the timer prematurely.
            if !timerModel.isStopped {
                print("is stopped block")
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                timerModel.resetTimerUI()
                timerModel.stopTimer()
            }
            else {
                isPresentedView = true
            }
        } label: {
            ZStack {
                Circle()
                    .fill(.timerCircle)
                    .brightness(0.2)
                    .shadow(color: .timerCircle.opacity(0.7), radius: 15)
                Image(systemName: timerModel.isStopped ? "timer" : "pause.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
            .frame(width: 80, height: 80)
        }

    }
}

#Preview(traits: .timerPreview) {
    @Previewable @State var isPresented = false
    
    TimerButtonView(isPresentedView: $isPresented)
        .preferredColorScheme(.dark)
}
