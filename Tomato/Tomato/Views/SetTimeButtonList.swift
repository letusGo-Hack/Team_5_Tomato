//
//  SetTimeButtonList.swift
//  Tomato
//
//  Created by 임경빈 on 6/29/24.
//

import SwiftUI

struct SetTimeButtonList: View {
  var body: some View {
    HStack {
      Button {
        UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(15, forKey: "setTime")
        print(("\(UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.integer(forKey: "setTime") ?? 0)"))
      } label: {
        Text("15min")
          .foregroundStyle(.white)
          .padding()
          .background(.pink)
          .clipShape(.rect(cornerRadius: 12))
      }
      
      Button {
        UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(30, forKey: "setTime")
        UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.integer(forKey: "setTime")

      } label: {
        Text("30min")
          .foregroundStyle(.white)
          .padding()
          .background(.pink)
          .clipShape(.rect(cornerRadius: 12))
      }
      
      Button {
        UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(45, forKey: "setTime")
      } label: {
        Text("45min")
          .foregroundStyle(.white)
          .padding()
          .background(.pink)
          .clipShape(.rect(cornerRadius: 12))
      }
      
      Button {
        UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(60, forKey: "setTime")
      } label: {
        Text("60min")
          .foregroundStyle(.white)
          .padding()
          .background(.pink)
          .clipShape(.rect(cornerRadius: 12))
      }
    }
  }
}

#Preview {
  SetTimeButtonList()
}
