//
//  CustomDatePicker.swift
//  WishMaker
//
//  Created by Peter on 24.01.2025.
//

import Foundation
import UIKit

final class CustomDatePicker: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum Buttons {
            static let type: UIButton.ButtonType = .system
            static let backgroundColor: UIColor = .clear
            static let cancelTitle: String = "Cancel"
            static let doneTitle: String = "Done"
            static let stateTitle: UIControl.State = .normal
            static let font: UIFont = .systemFont(ofSize: 17, weight: .medium)
            static let titleColor: UIColor = .systemBlue
            static let stateTitleColor: UIControl.State = .normal
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 12
            static let height: CGFloat = 28
            static let width: CGFloat = 68
            static let cancelLeft: CGFloat = 12
            static let doneRight: CGFloat = 12
        }
        
        enum DatePicker {
            static let mode: UIDatePicker.Mode = .dateAndTime
            static let style: UIDatePickerStyle = .inline
            static let locale: Locale = Locale(identifier: "en_EN")
            static let themeStyle: UIUserInterfaceStyle = .dark
            static let backgroundColor: UIColor = .background
            static let horizontalOffset: CGFloat = 8
        }
    }
    
    // MARK: - Variables
    var cancelAction: (() -> Void)?
    var doneAction: (() -> Void)?
    
    // MARK: - Private fields
    private let cancelButton: UIButton = UIButton(type: Constants.Buttons.type)
    private let doneButton: UIButton = UIButton(type: Constants.Buttons.type)
    private let datePicker: UIDatePicker = UIDatePicker()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - Methods
    public func getDate() -> Date {
        datePicker.date
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = .background
        setUpButtons()
        setUpDatePicker()
    }
    
    private func setUpButtons() {
        for button in [cancelButton, doneButton] {
            button.backgroundColor = Constants.Buttons.backgroundColor
            button.titleLabel?.font = Constants.Buttons.font
            button.setTitleColor(Constants.Buttons.titleColor, for: Constants.Buttons.stateTitleColor)
        }
        
        doneButton.setTitle(Constants.Buttons.doneTitle, for: Constants.Buttons.stateTitle)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: Constants.Buttons.event)
        cancelButton.setTitle(Constants.Buttons.cancelTitle, for: Constants.Buttons.stateTitle)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: Constants.Buttons.event)
        
        addSubview(cancelButton)
        cancelButton.pinTop(to: self, Constants.Buttons.top)
        cancelButton.pinLeft(to: self, Constants.Buttons.cancelLeft)
        cancelButton.setHeight(Constants.Buttons.height)
        cancelButton.setWidth(Constants.Buttons.width)
        
        addSubview(doneButton)
        doneButton.pinTop(to: self, Constants.Buttons.top)
        doneButton.pinRight(to: self, Constants.Buttons.doneRight)
        doneButton.setHeight(Constants.Buttons.height)
        doneButton.setWidth(Constants.Buttons.width)
    }
    
    private func setUpDatePicker() {
        datePicker.datePickerMode = Constants.DatePicker.mode
        datePicker.preferredDatePickerStyle = Constants.DatePicker.style
        datePicker.locale = Constants.DatePicker.locale
        datePicker.overrideUserInterfaceStyle = Constants.DatePicker.themeStyle
        datePicker.backgroundColor = Constants.DatePicker.backgroundColor

        addSubview(datePicker)
        datePicker.pinHorizontal(to: self, Constants.DatePicker.horizontalOffset)
        datePicker.pinTop(to: cancelButton.bottomAnchor)
        datePicker.pinBottom(to: self)
    }
    
    // MARK: - Actions
    @objc
    private func cancelButtonTapped() {
        cancelAction?()
    }
    
    @objc
    private func doneButtonTapped() {
        doneAction?()
    }
}
