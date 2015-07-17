//
//  StatusMenuController.swift
//  Bright
//
//  Created by Josh Trommel on 2015-07-17.
//  Copyright (c) 2015 Intui. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var statusBar = NSStatusBar.systemStatusBar()
    let menu = NSMenu()
    
    override func awakeFromNib() {
        statusItem.image = NSImage(named: "icon")
        statusItem.alternateImage = NSImage(named: "alt_icon")
        
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: ""))
        statusItem.menu = menu
    }
    
    @IBAction func query(sender: AnyObject?) {
        println("test")
    }

}