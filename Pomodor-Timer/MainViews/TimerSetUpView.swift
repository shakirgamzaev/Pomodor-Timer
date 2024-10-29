//
//  TimerSetUpView.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 25/10/24.
//

import SwiftUI

/// this view is present inside a sheet that gets shown from the ContentView, and its purpose is to set the number of hours, minutes and seconds that the timer will go
struct TimerSetUpView: View {
    @Binding var isSetUpViewShown: Bool
    @Environment(TimerModel.self) private var timerModel
    @Environment(\.dismiss) private var dismiss
    
    var isDisabledSaveButton: Bool {
        return (timerModel.hours == 0 && timerModel.minutes == 0 && timerModel.seconds == 0)
    }
    
    var body: some View {
        VStack {
            Text("Add New Timer")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
            Spacer()
            HStack(spacing: 20) {
                TimeButton(isSetUpViewShown: $isSetUpViewShown, timeType: .hour)
                TimeButton(isSetUpViewShown: $isSetUpViewShown, timeType: .minute)
                TimeButton(isSetUpViewShown: $isSetUpViewShown, timeType: .second)
            }
            Spacer()
            Button {
                //start timer
                timerModel.startTimer()
                dismiss()
            } label: {
                Text("Save")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.title3)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(.timerCircle, in: Capsule())
            }
            .disabled(isDisabledSaveButton)
            .opacity(isDisabledSaveButton ? 0.5 : 1.0)
        }
    }
}

#Preview(traits: .timerPreview) {
    TimerSetUpView(isSetUpViewShown: .constant(false))
        .frame(maxHeight: 200)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.BG)
}
