//
//  NSDraggingInfo+FilePathURL.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 17.01.2023.
//

import Foundation
import AppKit

extension NSDraggingInfo {
    var filePathURLs: [URL] {
        var urls: [URL] = []
        
        let filenames = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String]
        
        if let filenames = filenames {
            for filename in filenames {
                urls.append(URL(fileURLWithPath: filename))
            }
            return urls
        }
        
        return []
    }
}
