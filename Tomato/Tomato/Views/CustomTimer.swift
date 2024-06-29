//
//  CustomTimer.swift
//  Tomato
//
//  Created by 임경빈 on 6/29/24.
//

import SwiftUI

struct CustomTimer: View {
  @State var timeRemaining : Int = 0
  @State private var hours = 0
  @State private var minutes = 0
  @State private var seconds = 0
  @State private var typpedTime: String = ""
  @State var isTimerRunning = false
  
  let date = Date()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  var body: some View {
    VStack {
      let size: CGSize = .init(width: 80, height: 100)
      HStack {
        FlipClockTextEffect(value: $hours, size: size, fontSize: 40, cornerRadius: 18, foreground: .white, background: .pink)
        Text(":")
          .font(.system(size: 50, weight: .bold))
        FlipClockTextEffect(value: $minutes, size: size, fontSize: 40, cornerRadius: 18, foreground: .white, background: .pink)
        Text(":")
          .font(.system(size: 50, weight: .bold))
        FlipClockTextEffect(value: $seconds, size: size, fontSize: 40, cornerRadius: 18, foreground: .white, background: .pink)
      }
      .padding(.top, 50)
      
      Spacer()
      
      VStack(spacing: 20) {
        SetTimeButtonList()
        
        TextField("타이머 시간을 입력해주세요.", text: $typpedTime)
          .frame(maxWidth: .infinity, alignment: .center)
          .padding()
          .overlay {
            RoundedRectangle(cornerRadius: 20)
              .strokeBorder(.pink, lineWidth: 2)
          }
          .keyboardType(.numberPad)
        
        Button(action: {
          print(UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.bool(forKey: "start"))
        }) {
          Text(isTimerRunning ? "Pause" : "Start")
            .padding()
            .background(isTimerRunning ? Color.red : Color.pink)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
      }
    }
    .onReceive(timer) { _ in
      UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(timeRemaining, forKey: "currentTime")
      print(timeRemaining)
      
      if let isActionButton = UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.bool(forKey: "start") {
        if isActionButton {
          timeRemaining = 60
        } else {
          timeRemaining = 0
        }
      }
      if timeRemaining > 0 {
        timeRemaining -= 1
        setTime(timeInSeconds: timeRemaining)
      }
    }
  }
  
  func setTime(timeInSeconds: Int) {
    hours = timeInSeconds / 3600
    minutes = (timeInSeconds - hours * 3600) / 60
    seconds = timeInSeconds % 60
  }
  
  func calcRemain() {
    let calendar = Calendar.current
    let targetTime : Date = calendar.date(byAdding: .second, value: Int(typpedTime) ?? 0, to: date, wrappingComponents: false) ?? Date()
    let remainSeconds = Int(targetTime.timeIntervalSince(date))
    self.timeRemaining = remainSeconds
  }
}

#Preview {
  CustomTimer()
}
