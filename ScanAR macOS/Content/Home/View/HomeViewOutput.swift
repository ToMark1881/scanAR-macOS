//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeViewOutput.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

protocol HomeViewOutput: AnyObject {
    func onViewDidLoad()
    func onGeneratePreviewTap()
    func onCreateModelTap()
    
    func onReducedQualitySelect()
    func onMediumQualitySelect()
    func onFullQualitySelect()
    func onRawQualitySelect()
}
