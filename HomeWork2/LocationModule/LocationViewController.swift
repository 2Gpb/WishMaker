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
    private let settingsView = UIView()

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
        setUpSettingsView()
        setUpSettingsButton()
    }
    
    private func setUpSettingsButton() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.tintColor = .white
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchUpInside)
        view.addSubview(settingsButton)
        settingsButton.setHeight(40)
        settingsButton.setWidth(40)
        settingsButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        settingsButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 15)
    }
    
    @objc
    private func showSettings() {
        UIView.animate(withDuration: 0.1) {
            self.settingsView.alpha = 1 - self.settingsView.alpha
        }
    }
    
    private func setUpSettingsView() {
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.backgroundColor = .lightGray
        settingsView.alpha = 0
        view.addSubview(settingsView)
        settingsView.setHeight(300)
        settingsView.setWidth(200)
        settingsView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 10)
        settingsView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 10)
        
    }
}


