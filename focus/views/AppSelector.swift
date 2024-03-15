//
//  AppSelector.swift
//  focus
//

import Foundation
import AppKit

class AppSelector: NSWindowController, NSTableViewDataSource, NSTableViewDelegate {
    var tableView: NSTableView!
    var installedApps: [InstalledApp] = []
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        installedApps = getInstalledApps()
        
        // Create and configure the table view
        tableView = NSTableView()
        tableView.delegate = self
        tableView.dataSource = self
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "AppsColumn"))
        tableView.addTableColumn(column)
        
        // Create a scroll view and add the table view to it
        let scrollView = NSScrollView()
        scrollView.documentView = tableView
        scrollView.hasVerticalScroller = true
        window?.contentView?.addSubview(scrollView)
        scrollView.frame = (window?.contentView?.bounds)!
        
        // Button
        let button = NSButton(title: "Focus", target: self, action: #selector(buttonPressed))
        window?.contentView?.addSubview(button)
        button.frame = CGRect(x: 20, y: 20, width: 100, height: 30)
        
        // Adjust the scrollView frame to not overlap with the button
        scrollView.frame = NSRect(x: 0, y: 60, width: (window?.contentView?.frame.width)!, height: (window?.contentView?.frame.height)! - 60)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return installedApps.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let app = installedApps[row]
        let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "AppsCell")
        
        guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? NSTableCellView else {
            let cellView = NSTableCellView()
            cellView.identifier = cellIdentifier
            
            let textField = NSTextField(labelWithString: app.name)
            textField.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
            cellView.addSubview(textField)
            
            let toggle = NSSwitch(frame: CGRect(x: 200, y: 0, width: 50, height: 20))
            toggle.state = app.isAllowed ? .on : .off
            cellView.addSubview(toggle)
            
            return cellView
        }
        
        return cellView
    }
    
    @objc func buttonPressed() {
        print("Button pressed")
    }
}
