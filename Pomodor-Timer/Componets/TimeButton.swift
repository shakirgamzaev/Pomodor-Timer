//
//  TimeButton.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 25/10/24.
//

import SwiftUI


/// This view is a button with a context Menu that presents the number of hours, minutes or seconds that can be set.
///
struct TimeButton: View {
    @Environment(TimerModel.self) private var timerModel
    @Binding var isSetUpViewShown: Bool
    let timeType: TimeType
    
    //dynamically calculates how many numbers to put int a ForEach loop, based on whether time type is hour, minute or second
    var numberOfItems: Int {
        switch timeType {
        case .hour:
            return 24
        case .minute:
            return 60
        case .second:
            return 60
        }
    }
    var timeText: String {
        switch timeType {
        case .hour:
            return "hr"
        case .minute:
            return "min"
        case .second:
            return "sec"
        }
    }
    
    var body: some View {
        Text("\(timeTypeToDisplay) \(timeText)")
            .font(.title3)
            .foregroundStyle(.white.opacity(0.8))
            .padding()
            .background(.bgCircle, in: Capsule())
            .contextMenu {
                if timeType == .second {
                    ForEach(1..<(numberOfItems), id: \.self) { i in
                        Button {
                            setTimeOnTimerModel(timeToSet: i)
                        } label: {
                            HStack {
                                Text("\(i) \(timeText)s")
                            }
                        }

                    }
                }
                else {
                    ForEach(0..<(numberOfItems), id: \.self) { i in
                        Button {
                            setTimeOnTimerModel(timeToSet: i)
                        } label: {
                            HStack {
                                Text("\(i) \(timeText)s")
                            }
                        }

                    }
                }
            }
    }
}

extension TimeButton {
    private func setTimeOnTimerModel(timeToSet: Int) {
        switch timeType {
        case .hour:
            timerModel.hours = timeToSet
        case .minute:
            timerModel.minutes = timeToSet
        case .second:
            timerModel.seconds = timeToSet
        }
    }
    
    var timeTypeToDisplay: Int {
        switch timeType {
        case .hour:
            return timerModel.hours
        case .minute:
            return timerModel.minutes
        case .second:
            return timerModel.seconds
        }
    }
}


enum TimeType {
    case hour, minute, second
}




#Preview(traits: .timerPreview) {
    @Previewable @State var isShown = false
    
    TimeButton(isSetUpViewShown: $isShown, timeType: .minute)
}
