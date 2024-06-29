//
//  TomatoTimerLiveActivity.swift
//  TomatoTimer
//
//  Created by 임경빈 on 6/29/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct TomatoTimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct TomatoTimerLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TomatoTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension TomatoTimerAttributes {
    fileprivate static var preview: TomatoTimerAttributes {
        TomatoTimerAttributes(name: "World")
    }
}

extension TomatoTimerAttributes.ContentState {
    fileprivate static var smiley: TomatoTimerAttributes.ContentState {
        TomatoTimerAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: TomatoTimerAttributes.ContentState {
         TomatoTimerAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: TomatoTimerAttributes.preview) {
   TomatoTimerLiveActivity()
} contentStates: {
    TomatoTimerAttributes.ContentState.smiley
    TomatoTimerAttributes.ContentState.starEyes
}
