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
        var startTime: Date
    }

    // Fixed non-changing properties about your activity go here!
    var duration: Double = 60 * 30
}

struct TomatoTimerLiveActivity: Widget {
    @State var timePassed: Double = 0
    @State var isShowing: Bool = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TomatoTimerAttributes.self) { context in
            // Lock screen/banner UI goes here
            if (isShowing) {
                VStack {
                    HStack{
                        Text("🍅")
                        Text("wharrup").padding()
                    }
                    Text("\(Int(timePassed)) seconds passed").padding()
                }
                .activityBackgroundTint(Color.cyan)
                .activitySystemActionForegroundColor(Color.black)
                .onReceive(timer) { _ in
                    timePassed = timePassed + 1
                    if (timePassed > context.attributes.duration) {
                        isShowing = false
                    }
                }
            } else {
                VStack {
                    HStack{
                        Text("🍅🍅🍅🍅🍅🍅🍅")
                        Text("time is running out").padding()
                    }
                    Text("DONE").padding()
                }
                .activityBackgroundTint(Color.cyan)
                .activitySystemActionForegroundColor(Color.black)
            }

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
//                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
//                Text("T \(context.state.emoji)")
            } minimal: {
//                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

func requestLiveActivity(duration: Double) {
    let currentTime = Date()
    let timerAttribute = TomatoTimerAttributes(duration: duration)
    let initialState = TomatoTimerAttributes.ContentState(startTime: currentTime)
    let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 0.0)
    do {
        let activity = try Activity.request(
            attributes: timerAttribute,
            content: content,
            pushType: nil
        )
    } catch {
        print("Can not request Live Activity.")
    }
}

func updateLiveActivity() {
    //update timePassed
}

extension TomatoTimerAttributes {
    fileprivate static var preview: TomatoTimerAttributes {
        TomatoTimerAttributes(duration: 60*30)
    }
}

extension TomatoTimerAttributes.ContentState {
    fileprivate static var smiley: TomatoTimerAttributes.ContentState {
        TomatoTimerAttributes.ContentState(startTime: Date())
     }
     
     fileprivate static var starEyes: TomatoTimerAttributes.ContentState {
         TomatoTimerAttributes.ContentState(startTime: Date())
     }
}

#Preview("Notification", as: .content, using: TomatoTimerAttributes.preview) {
   TomatoTimerLiveActivity()
} contentStates: {
    TomatoTimerAttributes.ContentState.smiley
    TomatoTimerAttributes.ContentState.starEyes
}
