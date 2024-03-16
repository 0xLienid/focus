//
//  AppLaunchObserver.swift
//  focus
//

import Foundation
import AppKit

class AppLaunchObserver: ObservableObject {
    @Published var focusActive: Bool = false
    private var allowedApps: [String] = []
    
    init() {
        let notificationCenter = NSWorkspace.shared.notificationCenter
        notificationCenter.addObserver(self, selector: #selector(reportAppLaunch(notification: )), name: NSWorkspace.didLaunchApplicationNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(reportAppUnhide(notification: )), name:
            NSWorkspace.didUnhideApplicationNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(reportAppUnhide(notification: )), name:
            NSWorkspace.didActivateApplicationNotification, object: nil)
    }
    
    @objc func reportAppLaunch(notification: NSNotification) {
        if (!focusActive) {
            return
        }
        
        if let userInfo = notification.userInfo {
            let app = userInfo[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication
            if let appName = app?.localizedName {
                if (!allowedApps.contains(appName)) {
                    print("Accessing illegal app!")
                    let result = app?.forceTerminate()
                    
                    if (!result!) {
                        print("Failed to kill app")
                    }
                }
            }
        }
    }
    
    @objc func reportAppUnhide(notification: NSNotification) {
        if (!focusActive) {
            return
        }
        
        if let userInfo = notification.userInfo {
            let app = userInfo[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication
            if let appName = app?.localizedName {
                if (!allowedApps.contains(appName)) {
                    print("Accessing illegal app!")
                    let result = app?.hide()
                    
                    if (!result!) {
                        print("Failed to hide app")
                    }
                }
            }
        }
    }
    
    func setFocusActive(active: Bool) {
        self.focusActive = active
    }
    
    func setAllowedApps(apps: [String]) {
        self.allowedApps = apps
    }
}
