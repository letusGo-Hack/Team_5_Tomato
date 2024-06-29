//
//  TomatoTimerBundle.swift
//  TomatoTimer
//
//  Created by 임경빈 on 6/29/24.
//

import WidgetKit
import SwiftUI

@main
struct TomatoTimerBundle: WidgetBundle {
    var body: some Widget {
        TomatoTimer()
        TimerToggle()
        TomatoTimerLiveActivity()
    }
}
