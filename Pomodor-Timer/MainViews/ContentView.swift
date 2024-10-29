//
//  ContentView.swift
//  Pomodor-Timer
//
//  Created by shakir Gamzaev on 24/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var screenSize: CGSize = .zero
    @State private var isTimerSetupViewPresented = false
    
    var body: some View {
        VStack {
            Text("Pomodore Timer")
                .foregroundStyle(.white)
                .font(.title2)
                .bold()
            Spacer()
            TimerCircleView(isTimerViewPresented: $isTimerSetupViewPresented, screenWidth: screenSize.width)
            Spacer()
            TimerButtonView(isPresentedView: $isTimerSetupViewPresented)
            
        }
        .safeAreaPadding(.vertical, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.BG))
        .preferredColorScheme(.dark)
        .onGeometryChange(for: CGSize.self) { geo in
            geo.size
        } action: { newValue in
            screenSize = newValue
        }
        .sheet(isPresented: $isTimerSetupViewPresented) {
            TimerSetUpView(isSetUpViewShown: $isTimerSetupViewPresented)
                .padding(.top, 20)
                .padding(.bottom, 10)
                .presentationDetents([.fraction(0.3)])
                .presentationCornerRadius(20)
                .presentationBackground {
                    Color.bgCircle.brightness(-0.13)
                }
        }

    }
}

#Preview(traits: .timerPreview) {
    ContentView()
}
