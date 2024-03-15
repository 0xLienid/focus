//
//  ContentView.swift
//  focus
//

import SwiftUI

struct ContentView: View {
    @State private var allApps = getInstalledApps()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Select Allowed Apps")
                .frame(maxWidth: .infinity, alignment: .leading)
            List(allApps.indices, id: \.self) { index in
                HStack{
                    Text(allApps[index].name)
                    Spacer()
                    Toggle("", isOn: $allApps[index].isAllowed
                    ).labelsHidden()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        Button("Focus") {
            print ("button pressed")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    ContentView()
}
