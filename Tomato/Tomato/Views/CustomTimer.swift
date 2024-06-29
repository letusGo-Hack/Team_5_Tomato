//
//  CustomTimer.swift
//  Tomato
//
//  Created by 임경빈 on 6/29/24.
//

import SwiftUI

struct CustomTimer: View {
  @State var timeRemaining : Int = 60
  @State var isTimerRunning = false
  let date = Date()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack {
      let size: CGSize = .init(width: 100, height: 120)
      FlipClockTextEffect(value: $timeRemaining, size: size, fontSize: 60, cornerRadius: 18, foreground: .white, background: .pink)
        .onReceive(timer) { _ in
          print(timeRemaining)
          if isTimerRunning && timeRemaining > 0 {
            timeRemaining -= 1
          }
        }
      
      Button(action: {
        isTimerRunning.toggle()
      }) {
        Text(isTimerRunning ? "Pause" : "Start")
          .padding()
          .background(isTimerRunning ? Color.red : Color.green)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    }
    .onAppear {
      calcRemain()
    }
  }
}

extension CustomTimer {
  func convertSecondsToTime(timeInSeconds: Int) -> String {
    let hours = timeInSeconds / 3600
    let minutes = (timeInSeconds - hours * 3600) / 60
    let seconds = timeInSeconds % 60
    return String(format: "%02i:%02i:%02i", hours,minutes,seconds)
  }
  
  func calcRemain() {
    let calendar = Calendar.current
    let targetTime : Date = calendar.date(byAdding: .second, value: 3810, to: date, wrappingComponents: false) ?? Date()
    let remainSeconds = Int(targetTime.timeIntervalSince(date))
    self.timeRemaining = remainSeconds
  }
}

#Preview {
  CustomTimer()
}
