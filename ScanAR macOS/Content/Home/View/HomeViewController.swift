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
    
    @IBOutlet weak var reducedRadioButton: NSButton!
    @IBOutlet weak var mediumRadioButton: NSButton!
    @IBOutlet weak var fullRadioButton: NSButton!
    @IBOutlet weak var rawRadioButton: NSButton!
    
    @IBOutlet weak var dragAndDropView: DragAndDropView!
    
    @IBOutlet weak var generatePreviewButton: NSButton!
    @IBOutlet weak var createModelButton: NSButton!
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
        case reducedRadioButton:
            output.onReducedQualitySelect()
            
        case mediumRadioButton:
            output.onMediumQualitySelect()
            
        case fullRadioButton:
            output.onFullQualitySelect()
            
        case rawRadioButton:
            output.onRawQualitySelect()
            
        default:
            break
        }
    }
    
    @IBAction func didTapOnGeneratePreviewButton(_ sender: Any) {
        output.onGeneratePreviewTap()
    }
    
    @IBAction func didTapOnCreateModelButton(_ sender: Any) {
        output.onCreateModelTap()
    }
    
    func changeMainText(_ text: String) {
        self.label.stringValue = text
    }
    
    func setupUI() { }
    
}
