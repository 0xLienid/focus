////
////  WebsiteFilterProvider.swift
////  focus
////
//
//import Foundation
//import NetworkExtension
//
//class WebsiteFilterProvider: NEFilterDataProvider, ObservableObject {
//    private var isFilteringEnabled: Bool = false
//    private var allowedSites: [String] = []
//    
//    override func handleNewFlow(_ flow: NEFilterFlow) -> NEFilterNewFlowVerdict {
//        guard isFilteringEnabled else {
//            return .allow()
//        }
//        
//        if let url = flow.url {
//            if shouldBlock(url: url) {
//                return .drop()
//            }
//        }
//        
//        return .allow()
//    }
//    
//    func setIsFilteringEnabled(filter: Bool) {
//        self.isFilteringEnabled = filter
//    }
//    
//    func setAllowedSites(sites: [String]) {
//        self.allowedSites = sites
//    }
//    
//    private func shouldBlock(url: URL) -> Bool {
//        print(allowedSites)
//        print(url.host()!)
//        if (!allowedSites.contains(url.host()!)) {
//            return true
//        }
//        
//        return false
//    }
//}
