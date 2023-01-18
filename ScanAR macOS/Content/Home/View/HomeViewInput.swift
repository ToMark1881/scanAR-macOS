//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeViewInput.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

protocol HomeViewInput: BaseViewControllerProtocol {
    func setup(with configuration: HomeViewConfiguration)
    
    func showLoading()
    func updateProgress(_ value: Double)
    func setModelAsset(_ asset: ModelAsset)
}
