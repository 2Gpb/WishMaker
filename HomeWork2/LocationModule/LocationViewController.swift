//
//  ViewController.swift
//  HomeWork2
//
//  Created by Peter on 27.10.2024.
//

import UIKit

class LocationViewController: UIViewController {
    //MARK: - Properties
    private let settingsButton = UIButton(type: .system)

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - Variables
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //MARK: - Setup
    private func setUp() {
        view.backgroundColor = .darkGray
        setUpSettingssButton()
    }
    
    private func setUpSettingssButton() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.tintColor = .white
        view.addSubview(settingsButton)
        settingsButton.setHeight(40)
        settingsButton.setWidth(40)
        settingsButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        settingsButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 15)
    }
}


