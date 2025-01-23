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
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum View {
            static let height: CGFloat = 46
        }
        
        enum Button {
            static let titleColor: UIColor = .cells
            static let state: UIControl.State = .normal
            static let fontSize: CGFloat = 17
            static let fontWeight: UIFont.Weight = .bold
            static let backgroundColor: UIColor = .lightGray
            static let cornerRadius: CGFloat = 18
            static let event: UIControl.Event = .touchUpInside
            static let height: CGFloat = 46
        }
    }
    
    // MARK: - Variables
    var action: (() -> Void)?
    
    // MARK: - Fields
    let button: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    init(title: String) {
        super.init(frame: .zero)
        self.button.setTitle(title, for: .normal)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    private func setUp() {
        self.setHeight(Constants.View.height)
        
        button.setTitleColor(Constants.Button.titleColor, for: Constants.Button.state)
        button.titleLabel?.font = 
            .systemFont(
                ofSize: Constants.Button.fontSize,
                weight: Constants.Button.fontWeight
            )
        button.backgroundColor = Constants.Button.backgroundColor
        button.layer.cornerRadius = Constants.Button.cornerRadius
        button.addTarget(self, action: #selector(buttonTapped), for: Constants.Button.event)
        
        self.addSubview(button)
        button.pin(to: self)
    }
    
    // MARK: - Actions
    @objc
    private func buttonTapped() {
        action?()
    }
}
