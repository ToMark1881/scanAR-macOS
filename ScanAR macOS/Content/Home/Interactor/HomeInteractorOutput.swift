//  VIPER Template created by Vladyslav Vdovychenko
//  
//  HomeInteractorOutput.swift
//  ScanAR macOS
//
//  Created by Vladyslav Vdovychenko on 16.01.2023.
//

import Foundation

protocol HomeInteractorOutput: AnyObject {
    func didUpdateProgress(fraction: Double, for request: SessionRequest)
    func didReceiveError(_ error: Error)
    func didGeneratePreview(model: Model, for request: SessionRequest)
    func didGenerateModel(with outputURL: URL, for request: SessionRequest)
}
