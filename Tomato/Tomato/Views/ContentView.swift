//
//  ContentView.swift
//  Tomato
//
//  Created by Seokjune Hong on 6/29/24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack(spacing: 30) {
      Text("Tomato Timer")
        .font(.title)
        .foregroundStyle(.pink)
      
      CustomTimer()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
