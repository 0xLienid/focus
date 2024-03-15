//
//  utils.swift
//  focus
//

import Foundation
import AppKit

func getInstalledApps() -> [InstalledApp] {
    var appNames = [InstalledApp]()
    
    let fileManager = FileManager.default
    if let appsURL = fileManager.urls(for: .applicationDirectory, in: .localDomainMask).first {
        if let enumerator = fileManager.enumerator(at: appsURL, includingPropertiesForKeys: nil, options: .skipsSubdirectoryDescendants) {
            while let element = enumerator.nextObject() as? URL {
                if element.pathExtension == "app" {
                    let foundApp = InstalledApp(name: element.deletingPathExtension().lastPathComponent, isAllowed: false)
                    appNames.append(foundApp)
                }
            }
        }
    }
    
    return appNames
}

func getActiveApps() -> [NSRunningApplication] {
    let workspace = NSWorkspace.shared
    let apps = workspace.runningApplications.filter{ $0.activationPolicy == .regular }
    return apps
}
