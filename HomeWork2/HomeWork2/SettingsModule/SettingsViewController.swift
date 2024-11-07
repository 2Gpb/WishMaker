//
//  SettingsViewController.swift
//  HomeWork2
//
//  Created by Peter on 27.10.2024.
//

import UIKit
import CoreLocation

//MARK: - SettingsViewControllerDelegate
protocol SettingsViewControllerDelegate: AnyObject {
    func toggleSwitch(_ isOn: Bool)
}

final class SettingsViewController: UIViewController {
    //MARK: - Variables
    weak var delegate: SettingsViewControllerDelegate?
    
    //MARK: - Properties
    private let locationToggle = UISwitch()
    private let locationLabel = UILabel()
    private let closeButton = UIButton(type: .close)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    //MARK: - Setup
    private func setUp() {
        view.backgroundColor = .white
        setUpLocationLabel()
        setUpLocationToggle()
        setUpCloseButton()
    }
    
    private func setUpLocationToggle() {
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.addTarget(self, action: #selector(locationToggleSwitched), for: .touchUpInside)
        view.addSubview(locationToggle)
        locationToggle.pinTop(to: locationLabel.bottomAnchor, 5)
        locationToggle.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    @objc
    private func locationToggleSwitched() {
        delegate?.toggleSwitch(locationToggle.isOn)
    }
    
    private func setUpLocationLabel() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.text = "Location"
        locationLabel.font = .systemFont(ofSize: 14, weight: .medium)
        view.addSubview(locationLabel)
        locationLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 60)
        locationLabel.pinCenterX(to: view.safeAreaLayoutGuide.centerXAnchor)
    }
    
    private func setUpCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        view.addSubview(closeButton)
        closeButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 15)
        closeButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 15)
        closeButton.setHeight(40)
        closeButton.setWidth(40)
    }
    
    @objc
    private func closeScreen() {
        dismiss(animated: true)
        navigationController?.popViewController(animated: true)
    }
}
