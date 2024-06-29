//
//  TimerToggle.swift
//  Tomato
//
//  Created by 정지훈 on 6/29/24.
//

import Foundation
import SwiftUI
import AppIntents
import WidgetKit


struct TimerToggle: ControlWidget {
    static let kind: String = "com.example.MyApp.TimerToggle"


    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: Self.kind,
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "Timer",
                isOn: TimerManager.shared.isRunning,
                action: ToggleTimerIntent(),
                valueLabel: { isOn in
                    Label(isOn ? "Running" : "Stopped", systemImage: "timer")
                }
            )
            .tint(.red)
        }
        .displayName("TomatoTimer")
        .description("Start and stop.")
        
    }
}


extension TimerToggle {
    
    struct Provider: ControlValueProvider {
        var previewValue: Bool {
            false
        }


        func currentValue() async throws -> Bool {
            let isRunning = true // Check if the timer is running
            return isRunning
        }
    }
}


struct ToggleTimerIntent: SetValueIntent {
    static var title: LocalizedStringResource = "Productivity Timer"

    @Parameter(title: "Timer is running")
    var value: Bool
    
    
    func perform() async throws -> some IntentResult {
        TimerManager.shared.isRunning.toggle()
        return .result()
    }
}
