//
//  CustomButton.swift
//  HomeWork2
//
//  Created by Peter on 20.11.2024.
//

import UIKit

final class CustomButton: UIView {
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: UIColor = .white
        static let cornerRadius: CGFloat = 18
    }
    
    // MARK: - Variables
    var action: (() -> Void)?
    
    // MARK: - Private fields
    private let button: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        self.button.setTitle(title, for: .normal)
        self.setHeight(46)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func changeTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }

    // MARK: - SetUp
    private func setUp() {
        button.setTitleColor(.systemCyan, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = Constants.backgroundColor
        button.layer.cornerRadius = Constants.cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.addSubview(button)
        button.pin(to: self)
    }
    
    // MARK: - Actions
    @objc
    private func buttonTapped() {
        action?()
    }
}
