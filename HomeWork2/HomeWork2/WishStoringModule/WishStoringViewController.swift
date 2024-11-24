//
//  WishStoringViewController.swift
//  HomeWork2
//
//  Created by Peter on 24.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Fields
    private let closeButton: UIButton = UIButton(type: .close)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUp()
    }
    
    // MARK: - Setup
    private func setUp() {
        setupCloseButton()
    }
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector (closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)
        
        closeButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        closeButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 20)
        closeButton.setHeight(40)
        closeButton.setWidth(40)
    }
    
    // MARK: - Actions
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true)
    }
}
