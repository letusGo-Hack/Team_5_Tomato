//
//  PerfomActionButton.swift
//  Tomato
//
//  Created by 정지훈 on 6/29/24.
//

import Foundation
import SwiftUI
import WidgetKit
import AppIntents

struct PerformActionButton: ControlWidget {
    var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "com.example.myApp.performActionButton"
        ) {
            ControlWidgetButton(action: PerformAction()) {
                Label("Perform Action", image: "tomato-control-white-2")
            }
        }
        .displayName("Perform Action")
        .description("An example control that performs an action.")
    }
}


struct PerformAction: AppIntent {
    static let title: LocalizedStringResource = "Perform action"


    func perform() async throws -> some IntentResult {
        // Code that performs the action...
        return .result()
    }
}
