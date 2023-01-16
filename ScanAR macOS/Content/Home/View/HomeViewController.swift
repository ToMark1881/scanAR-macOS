//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeViewController.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Cocoa

final class HomeViewController: NSViewController {
    
    var output: HomeViewOutput!

    @IBOutlet weak var label: NSTextField!
    
    @IBOutlet weak var previewRadioButton: NSButton!
    @IBOutlet weak var lowRadioButton: NSButton!
    @IBOutlet weak var mediumRadioButton: NSButton!
    @IBOutlet weak var highRadioButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension HomeViewController: HomeViewInput {

}

private extension HomeViewController {
    
    @IBAction func didChangeRadioButtonValue(_ sender: NSButton) {
        switch sender {
        case previewRadioButton:
            printRadioButton("preview")
            
        case lowRadioButton:
            printRadioButton("low")
            
        case mediumRadioButton:
            printRadioButton("medium")
            
        case highRadioButton:
            printRadioButton("high")
            
        default:
            break
        }
    }
    
    func printRadioButton(_ text: String) {
        self.label.stringValue = text
    }
    
}
