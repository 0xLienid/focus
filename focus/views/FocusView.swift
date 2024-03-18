//
//  FocusView.swift
//  focus
//

import SwiftUI

struct FocusView: View {
    @State private var timeRemaining: String = ""
    @ObservedObject var timerData: TimerData
    @ObservedObject var appLaunchObserver: AppLaunchObserver
    @Binding var allowedAppsBinding: [String]
    @Binding var currentViewBinding: String
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func updateRemainingTime() {
        let currentDate = Date()
        let targetDate = timerData.futureTime
        let difference = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate, to: targetDate!)
        
        if let hour = difference.hour, let minute = difference.minute, let second = difference.second {
            if (hour < 0 || minute < 0 || second < 0) {
                appLaunchObserver.setFocusActive(active: false)
                currentViewBinding = "home"
            }
            
            timeRemaining = "\(hour)h \(minute)m \(second)s"
        }
    }
    
    var body: some View {
        VStack {
            Text("Current Focus Mode")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            Text(timeRemaining)
                .onAppear(perform: updateRemainingTime)
                .onReceive(timer) { _ in
                    updateRemainingTime()
                }
            Spacer()
            Text("Allowed Apps")
            List(allowedAppsBinding.filter{ $0 != NSRunningApplication.current.localizedName! }, id: \.self) { app in
                Text(app)
            }
        }
    }
}
