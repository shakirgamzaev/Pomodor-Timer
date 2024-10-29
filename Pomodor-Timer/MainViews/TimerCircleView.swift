//
//  TimerCircleView.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 24/10/24.
//

import SwiftUI


/*
 TODO:
   next i need to create a View model that will hold elapsedSeconds, total set time in seconds, but the split is between hour minutes and seconds. and set a timer on that view model so that everything works.
 */
struct TimerCircleView: View {
    @Environment(TimerModel.self) private var timerModel
    @Binding var isTimerViewPresented: Bool
    let screenWidth: CGFloat
    
    var bgCircleWidth: CGFloat {
        return screenWidth * 0.84
    }
    var circleWidth: CGFloat {
        return bgCircleWidth * 0.77
    }
    var overlayStrokeWidth: CGFloat {
        return bgCircleWidth - circleWidth
    }
    
    var body: some View {
        @Bindable var timer = timerModel
        ZStack {
            Circle()
                .fill(Color(.bgCircle).opacity(0.3))
                .frame(width: bgCircleWidth, height: bgCircleWidth)
            Circle()
                .fill(Color(.circle))
                .frame(maxWidth: circleWidth, maxHeight: circleWidth)
                .shadow(color: .purple.opacity(0.4), radius: 20)
            CirclePlusKnobView(knobWidth: 30, circleWidth: circleWidth, screenWidth: screenWidth)
            Text(timerModel.timeString)
                .font(.system(size: screenWidth * 0.12))
        }
        .animation(.easeInOut(duration: 0.2), value: timerModel.secondsElapsed)
        .alert("Hooray you finished", isPresented: $timer.isFinished) {
            Button(role: .cancel) {
                timerModel.resetTimerUI()
                isTimerViewPresented = true
            } label: {
                Text("Start New Timer")
            }
            Button(role: .destructive) {
                timerModel.resetTimerUI()
                //isTimerViewPresented = false
            } label: {
                Text("Finish")
            }

        }
    }
}




#Preview(traits: .timerPreview) {
    
    TimerCircleView(isTimerViewPresented: .constant(false), screenWidth: 400)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.BG))
        .preferredColorScheme(.dark)

}
