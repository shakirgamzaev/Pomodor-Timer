//
//  CircularKnobView.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 24/10/24.
//

import SwiftUI

struct CirclePlusKnobView: View {
    @Environment(TimerModel.self) private var timerModel
    let knobWidth: CGFloat
    let circleWidth: CGFloat
    let screenWidth: CGFloat
    //let elapsedSeconds: CGFloat
    
    var bgCircleWidth: CGFloat {
        return screenWidth * 0.84
    }
    
    var overlayStrokeWidth: CGFloat {
        return bgCircleWidth - circleWidth
    }
    var progress: CGFloat {
        return CGFloat(timerModel.secondsElapsed) / CGFloat(timerModel.totalSecondsSet)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 1.0 - ( CGFloat(timerModel.secondsElapsed) / CGFloat(timerModel.totalSecondsSet) ) )
                .stroke(.white.opacity(0.05), lineWidth: overlayStrokeWidth / 2)
                .padding(overlayStrokeWidth / 4)
                .frame(width: bgCircleWidth, height: bgCircleWidth)
                .rotationEffect(.degrees(270))
            Circle()
                .trim(from: 0.0, to: 1.0 - (  CGFloat(timerModel.secondsElapsed) / CGFloat(timerModel.totalSecondsSet) ) )
                .stroke(Color.timerCircle, lineWidth: 10)
                .frame(width: circleWidth, height: circleWidth)
                .rotationEffect(.degrees(270))
            
            ZStack {
                Circle()
                    .fill(.timerCircle)
                    .frame(width: knobWidth, height: knobWidth)
                    .offset(y: -bgCircleWidth / 2 + overlayStrokeWidth / 2)
                    .rotationEffect(.degrees ( -Double(360) * progress ))
            }
            //.position(x: xPosition, y: yPosition)
        }
        .frame(width: bgCircleWidth, height: bgCircleWidth)
    }
}


extension CirclePlusKnobView {
    
//    var xPosition: CGFloat {
//        return calculatePositionOfKnob().x
//    }
//    var yPosition: CGFloat {
//        return calculatePositionOfKnob().y
//    }
//    
//    func calculatePositionOfKnob() -> CGPoint {
//        let centerX = bgCircleWidth / 2
//        let centerY = bgCircleWidth / 2
//        let radius =  (bgCircleWidth / 2) - (overlayStrokeWidth / 2)
//        let angle = -(2.0 * .pi * ( CGFloat(timerModel.secondsElapsed) / CGFloat(timerModel.totalSecondsSet)  )  )  - (.pi / 2)
//        let xPosition = centerX + (radius * cos(angle))
//        let yPosition = centerY + (radius * sin(angle))
//        
//        return CGPoint(x: xPosition, y: yPosition)
//    }
}


#Preview(traits: .timerPreview) {
    CirclePlusKnobView(knobWidth: 30, circleWidth: 200, screenWidth: 400)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.BG)
}
