//
//  ContentView.swift
//  Timer_Sailing Watch App
//
//  Created by Lucas Pierce on 9/26/23.
//

import SwiftUI
import WatchKit

struct ContentView: View {
    @State private var remainingTime: Double = 180 // Starting with 3 minutes in seconds
    @State private var isTimerRunning: Bool = false
    @State private var isLocked: Bool = false
    @State private var currentMode: TimerMode = .upDown
    @State private var timerSelection: TimerSelection = .threeMin

    enum TimerMode {
        case upDown, repeatMode
    }

    enum TimerSelection {
        case threeMin, fiveMin
    }

    var body: some View {
        VStack(spacing: 8) {
            if !isTimerRunning {
                Text("\(Date(), formatter: DateFormatter.time)")
                    .font(.system(size: 14))

                HStack {
                    Button(action: switchTimer) {
                        ZStack {
                            Image(systemName: "clock.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                            Text(timerSelection == .threeMin ? "3" : "5")
                                .font(.footnote)
                        }
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(7)

                    Button(action: upDownOrRepeatAction) {
                        Image(systemName: currentMode == .upDown ? "arrow.up.arrow.down" : "arrow.2.circlepath")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(7)
                    .opacity(isTimerRunning ? 0.5 : 1.0)
                    .disabled(isTimerRunning)

                    Button(action: lockAction) {
                        Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(7)
                }
                .padding(.bottom, 8)
            } else {
                // Display the current state of the up/down or repeat button in the upper left of the screen
                HStack {
                    Image(systemName: currentMode == .upDown ? "arrow.up.arrow.down" : "arrow.2.circlepath")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .opacity(0.5)
                    Spacer()
                }
            }

            Text(timeString(remainingTime))
                .font(.system(size: isTimerRunning ? 60 : 54, weight: .bold, design: .rounded))
                .padding(.bottom, 8)

            if isTimerRunning {
                HStack {
                    Button(action: syncAction) {
                        Text("Sync")
                    }
                    .frame(width: 70, height: 45)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .cornerRadius(7)

                    Button(action: stopAction) {
                        Text("Stop")
                    }
                    .frame(width: 140, height: 45)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(7)
                }
            } else {
                HStack {
                    Button(action: resetAction) {
                        Text("Reset")
                    }
                    .frame(width: 70, height: 45)
                    .background(Color.yellow)
                    .foregroundColor(Color.black)
                    .cornerRadius(7)

                    Button(action: startAction) {
                        Text("Start")
                    }
                    .frame(width: 140, height: 45)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(7)
                }
            }
        }
        .padding(.horizontal, 4)
    }

   



    func switchTimer() {
        timerSelection = timerSelection == .threeMin ? .fiveMin : .threeMin
        resetAction() // Reset the timer when switched
    }

    func lockAction() {
        isLocked.toggle()
    }

    func upDownOrRepeatAction() {
        currentMode = currentMode == .upDown ? .repeatMode : .upDown
    }

    func startAction() {
        isTimerRunning = true
        // Add timer start logic here
    }

    func stopAction() {
        isTimerRunning = false
        // Add timer stop logic here
    }

    func syncAction() {
        let minutes = Int(remainingTime) / 60
        remainingTime = Double(minutes * 60)
    }

    func resetAction() {
        // Reset the timer based on current selection
        switch timerSelection {
            case .threeMin:
                remainingTime = 180
            case .fiveMin:
                remainingTime = 300
        }
    }

    func timeString(_ totalSeconds: Double) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}

extension DateFormatter {
    static let time: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}




#Preview {
    ContentView()
}
