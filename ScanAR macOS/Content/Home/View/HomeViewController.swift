//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeViewController.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Cocoa
import SceneKit

final class HomeViewController: NSViewController {
    
    var output: HomeViewOutput!
    
    @IBOutlet weak var reducedRadioButton: NSButton!
    @IBOutlet weak var mediumRadioButton: NSButton!
    @IBOutlet weak var fullRadioButton: NSButton!
    @IBOutlet weak var rawRadioButton: NSButton!
    
    @IBOutlet weak var dragAndDropView: DragAndDropView!
    
    @IBOutlet weak var generatePreviewButton: NSButton!
    @IBOutlet weak var createModelButton: NSButton!
    
    @IBOutlet weak var sceneView: SCNView!
    
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    @IBOutlet weak var progressLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.onViewDidLoad()
        setupUI()
    }
    
}

extension HomeViewController: HomeViewInput {
    
    func setup(with configuration: HomeViewConfiguration) {
        dragAndDropView.delegate = configuration.dragAndDropOutput
    }
    
    func setModelAsset(_ asset: ModelAsset) {
        generatePreviewButton.isEnabled = true
        createModelButton.isEnabled = true
        
        asset.loadTextures()
        
        let scene = SCNScene(mdlAsset: asset)
        sceneView.scene = scene
    }
    
    func showLoading() {
        generatePreviewButton.isEnabled = false
        createModelButton.isEnabled = false
    }
    
    func updateProgress(_ value: Double) {
        progressIndicator.doubleValue = value
        progressLabel.stringValue = "\(Int(value).description)%"
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
    
    func setupUI() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.showsStatistics = true
        sceneView.allowsCameraControl = true
    }
    
}
