//
//  TimerData.swift
//  focus
//

import Foundation

class TimerData: ObservableObject {
    @Published var minutes: Int?
    @Published var futureTime: Date?
    
    func setMinutes(minutes: Int) {
        self.minutes = minutes
    }
    
    func setFutureTime() {
        let currentTime = Date()
        let futureTime = Calendar.current.date(byAdding: .minute, value: self.minutes!, to: currentTime)
        self.futureTime = futureTime
    }
}
