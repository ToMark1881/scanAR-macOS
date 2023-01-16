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

    @IBOutlet weak var cell: NSTextFieldCell!
    @IBOutlet weak var label: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.label.stringValue = "Hello, 123"
        }
    }

}

extension HomeViewController: HomeViewInput {

}
