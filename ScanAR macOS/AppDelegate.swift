//
//  AppDelegate.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 31.10.2022.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
        
    lazy var homeWireframe: HomeWireframe = { HomeWireframe() }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

}
