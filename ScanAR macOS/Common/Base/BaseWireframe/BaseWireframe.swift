//
//  BaseWireframe.swift
//
//
//  Created by macbook on 09.10.2020.
//

import Cocoa

class BaseWireframe {

    init() {
        Logger.shared.log("🆕 \(self)", type: .lifecycle)
    }
    
    deinit {
        Logger.shared.log("🗑 \(self)", type: .lifecycle)
    }

    func initializeController<T: NSViewController>() -> T? {
        return self.storyboard.instantiateController(withIdentifier: identifier()) as? T
    }

    var storyboard: NSStoryboard {
        get {
            return NSStoryboard(name: storyboardName(), bundle: nil)
        }
    }

    func storyboardName() -> String {
        assert(false, "Must ovveride")

        return ""
    }

    func identifier() -> String {
        assert(false, "Must ovveride")

        return ""
    }

}
