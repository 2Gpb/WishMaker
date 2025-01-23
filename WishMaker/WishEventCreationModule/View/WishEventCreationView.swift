//
//  WishEventCreationView.swift
//  WishMaker
//
//  Created by Peter on 23.01.2025.
//

import Foundation
import UIKit

protocol WishEventCreationViewDelegate: AnyObject {
    func goBackScreen()
}

final class WishEventCreationView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum View {
            static let backgroundColor: UIColor = .background
        }
        
        enum BackButton {
            static let image: UIImage = UIImage(systemName: "chevron.left") ?? UIImage()
            static let event: UIControl.Event = .touchUpInside
            static let state: UIControl.State = .normal
            static let color: UIColor = .white
            static let top: CGFloat = 8
            static let leading: CGFloat = 10
            static let height: CGFloat = 24
            static let width: CGFloat = 24
        }
    }
    
    // MARK: - Variables
    weak var delegate: WishEventCreationViewDelegate?
    
    // MARK: - Private fields
    private let backButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = Constants.View.backgroundColor
        setUpBackButton()
    }
    
    private func setUpBackButton() {
        backButton.setImage(Constants.BackButton.image, for: Constants.BackButton.state)
        backButton.tintColor = Constants.BackButton.color
        backButton.addTarget(self, action: #selector(goBackScreen), for: Constants.BackButton.event)
        
        addSubview(backButton)
        backButton.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.BackButton.top)
        backButton.pinLeft(to: safeAreaLayoutGuide.leadingAnchor, Constants.BackButton.leading)
        backButton.setHeight(Constants.BackButton.height)
        backButton.setWidth(Constants.BackButton.width)
    }
    
    // MARK: - Actions
    @objc
    func goBackScreen() {
        delegate?.goBackScreen()
    }
}
