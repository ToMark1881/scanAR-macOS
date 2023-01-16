//
//  MainWindowController.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    private lazy var homeWireframe: HomeWireframe = { HomeWireframe() }()

    override func windowDidLoad() {
        super.windowDidLoad()
        
        setupContentController()
    }
    
}

private extension MainWindowController {
    
    func setupContentController() {
        var moduleInput: HomeModuleInput?
        let controller = homeWireframe.createModule(moduleInput: &moduleInput, moduleOutput: nil)
        contentViewController = controller
    }
    
}
