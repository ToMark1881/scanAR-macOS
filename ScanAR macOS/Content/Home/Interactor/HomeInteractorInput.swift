//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeInteractorInput.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Cocoa

protocol HomeInteractorInput: AnyObject {
    var directoryURL: URL? { get set }
    var processingQuality: ProcessingQuality { get set }
    
    func generatePreview()
    func createModel()
    func shareModel(from sender: NSView)
}
