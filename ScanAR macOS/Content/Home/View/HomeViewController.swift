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
    @IBOutlet weak var selectDirectoryButton: NSButton!
    
    @IBOutlet weak var dragAndDropView: DragAndDropView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.onViewDidLoad()
        setupUI()
    }
    
}

extension HomeViewController: HomeViewInput {
    
    func setText(string: String) {
        changeMainText(string)
    }
    
    func setup(with configuration: HomeViewConfiguration) {
        dragAndDropView.delegate = configuration.dragAndDropOutput
    }

}

private extension HomeViewController {
    
    @IBAction func didChangeRadioButtonValue(_ sender: NSButton) {
        switch sender {
        case previewRadioButton:
            changeMainText("preview")
            
        case lowRadioButton:
            changeMainText("low")
            
        case mediumRadioButton:
            changeMainText("medium")
            
        case highRadioButton:
            changeMainText("high")
            
        default:
            break
        }
    }
    
    @IBAction func didTapOnSelectDirectoryButton(_ sender: Any) {
        output.onOpenDirectoryTap()
    }
    
    func changeMainText(_ text: String) {
        self.label.stringValue = text
    }
    
    func setupUI() { }
    
}
