//
//  TomatoTimerToggle.swift
//  Tomato
//
//  Created by Seokjune Hong on 6/29/24.
//

import SwiftUI
import WidgetKit
import AppIntents

struct TomatoTimerToggle: ControlWidget {
    static let kind: String = "com.example.MyApp.TimerToggle"


    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: Self.kind,
            provider: Provider()
        ) { value in
            ControlWidgetToggle(
                "타이머 🍅",
                isOn: value,
                action: ToggleTimerIntent(),
                valueLabel: { isOn in
                    Label(isOn ? "시작" : "정지", systemImage: "timer")
                }
            )
            .tint(.pink)
        }
        .displayName("타이머 시작/정지")
        .description("Start and stop a productivity timer.")
    }
}


extension TomatoTimerToggle {
    struct Provider: ControlValueProvider {
        var previewValue: Bool {
            true
        }


        func currentValue() async throws -> Bool {
            if let time = UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.integer(forKey: "currentTime"),
                time == 0 {
                // 타이머가 끝났을 때
                UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(true, forKey: "start")
                return true
            } else {
                // 타이머가 진행중일 때
                UserDefaults(suiteName: "group.letusgo.tomatoGroup")?.set(false, forKey: "start")
                return false
            }
        }
    }
}


struct ToggleTimerIntent: SetValueIntent {
    static var title: LocalizedStringResource = "타이머 🍅"


    @Parameter(title: "Timer is running")
    var value: Bool


    func perform() async throws -> some IntentResult {
        // Start / stop the timer based on `value`.
        return .result()
    }
}
