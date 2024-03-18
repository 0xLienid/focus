//
//  TimerSetterView.swift
//  focus
//

import SwiftUI

struct TimerSetterView: View {
    @State private var minutes: String = ""
    @FocusState private var isTimeEntryFocused: Bool
    @Binding var currentViewBinding: String
    @ObservedObject var timerData: TimerData
    
    var body: some View {
        VStack {
            Text("Enter focus time")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            TextField("Time (minutes)", text: $minutes)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isTimeEntryFocused)
                .onAppear {
                    DispatchQueue.main.async {
                        self.isTimeEntryFocused = true
                    }
                }
                .frame(width: 250, height: 50, alignment: .leading)
                .padding()
            HStack {
                Button("Back") {
                    currentViewBinding = "home"
                }
                .frame(alignment: .bottomLeading)
                .padding()
                Button("Next") {
                    if let minutesInt = Int(minutes) {
                        timerData.setMinutes(minutes: minutesInt)
                        currentViewBinding = "app-selection"
                    }
                }
                .frame(alignment: .bottomTrailing)
                .padding()
            }
        }
    }
}
