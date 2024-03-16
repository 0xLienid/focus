//
//  ContentView.swift
//  focus
//

import SwiftUI

struct ContentView: View {
    @State private var currentView = "home"
    @StateObject private var timerData = TimerData()
    @State private var allowedApps: [String] = []
    @State private var allApps: [InstalledApp]
    @StateObject private var appLaunchObserver: AppLaunchObserver = AppLaunchObserver()
    @State private var searchText = ""
    
    init() {
        _allApps = State(initialValue: getInstalledApps())
    }
    
    var filteredApps: [InstalledApp] {
        if (searchText.isEmpty) {
            return allApps
        } else {
            return allApps.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        switch currentView
        {
        case "home":
            VStack {
                Text("Focus")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("Build custom focus modes with only certain apps accessible")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Button("Begin") {
                    currentView = "time-selection"
                }
            }
            .padding()
        case "time-selection":
            TimerSetterView(currentViewBinding: $currentView, timerData: timerData)
        case "app-selection":
            VStack(alignment: .leading) {
                Text("Select Allowed Apps")
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Search...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(filteredApps.indices, id: \.self) { index in
                    HStack{
                        Text(self.filteredApps[index].name)
                        Spacer()
                        Toggle("", isOn: Binding(
                            get: { self.filteredApps[index].isAllowed },
                            set: { newValue in
                                if let originalIndex = self.allApps.firstIndex(where: { $0.id == self.filteredApps[index].id }) {
                                    allowedApps.append(self.allApps[originalIndex].name)
                                    self.allApps[originalIndex].isAllowed = newValue
                                }
                            }
                        )).labelsHidden()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack {
                Button("Back") {
                    currentView = "time-selection"
                }
                .padding()
                .frame(alignment: .bottomLeading)
                Button("Focus") {
                    timerData.setFutureTime()
                    appLaunchObserver.setAllowedApps(apps: allowedApps)
                    appLaunchObserver.setFocusActive(active: true)
                    hideIllegalApps(allowedApps: allowedApps)
                    currentView = "focus"
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
            }
        case "focus":
            FocusView(timerData: timerData, appLaunchObserver: appLaunchObserver, allowedAppsBinding: $allowedApps, currentViewBinding: $currentView)
        default:
            Text("Invalid view")
        }
    }
}

#Preview {
    ContentView()
}
