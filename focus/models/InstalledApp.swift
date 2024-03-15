//
//  InstalledApp.swift
//  focus
//

import Foundation

struct InstalledApp: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var isAllowed: Bool
}
