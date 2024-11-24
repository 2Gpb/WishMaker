//
//  CustomButton.swift
//  HomeWork2
//
//  Created by Peter on 20.11.2024.
//

import UIKit

final class CustomButton: UIButton {
    // MARK: - Constants
    private enum Constants {
        static let titleColor: UIColor = .systemPink
        static let backgroundColor: UIColor = .white
        static let cornerRadius: CGFloat = 20
    }
    
    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setUp() {
        setTitleColor(Constants.titleColor, for: .normal)
        titleLabel?.font = .preferredFont(forTextStyle: .headline)
        backgroundColor = Constants.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
}
