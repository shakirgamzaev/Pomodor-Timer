//
//  TimerPreview.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 25/10/24.
//

import Foundation
import SwiftUI


struct TimerPreview: PreviewModifier {
    
    static func makeSharedContext() async throws -> TimerModel {
        return TimerModel()
    }
    func body(content: Content, context: TimerModel) -> some View {
        content
            .environment(context)
    }
    
    typealias Context = TimerModel
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor static var timerPreview: Self = .modifier(TimerPreview())
}
