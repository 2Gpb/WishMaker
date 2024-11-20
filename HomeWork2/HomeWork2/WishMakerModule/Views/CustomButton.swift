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
        static let titleColor = UIColor.black
        static let backgroundColor = UIColor.clear
        static let borderWidth: CGFloat = 1
        static let cornerRadius: CGFloat = 10
        static let borderColor: CGColor = UIColor.black.cgColor
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
        backgroundColor = Constants.backgroundColor
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
