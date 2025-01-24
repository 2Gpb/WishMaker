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
    func createWishEvent(_ event: WishEvent)
}

final class WishEventCreationView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum View {
            static let backgroundColor: UIColor = .background
        }
        
        enum Buttons {
            static let type: UIButton.ButtonType = .system
            static let backgroundColor: UIColor = .clear
            static let cancelTitle: String = "Cancel"
            static let doneTitle: String = "Add"
            static let stateTitle: UIControl.State = .normal
            static let font: UIFont = .systemFont(ofSize: 17, weight: .semibold)
            static let titleColor: UIColor = .systemBlue
            static let stateTitleColor: UIControl.State = .normal
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 12
            static let height: CGFloat = 28
            static let width: CGFloat = 68
            static let cancelLeft: CGFloat = 12
            static let addRight: CGFloat = 6
        }
        
        enum TitleTextField {
            static let title: String = "Title"
            static let placeholder: String = "Enter the name of the event"
            static let top: CGFloat = 30
            static let horizontalOffset: CGFloat = 16
            static let height: CGFloat = 74
        }
        
        enum DescritionTextField {
            static let title: String = "Description"
            static let placeholder: String = "Enter a description"
            static let top: CGFloat = 20
            static let horizontalOffset: CGFloat = 16
            static let height: CGFloat = 74
        }
        
        enum StartDateTextField {
            static let title: String = "Start date"
            static let placeholder: String = "Enter the start date of the event"
            static let top: CGFloat = 20
            static let horizontalOffset: CGFloat = 16
            static let height: CGFloat = 74
            static let alignment: NSTextAlignment = .center
            static let datePickerFrame: CGRect = CGRect(x: 0, y: 0, width: 402, height: 520)
        }
        
        enum EndDateTextField {
            static let title: String = "End date"
            static let placeholder: String = "Enter the end date of the event"
            static let top: CGFloat = 20
            static let horizontalOffset: CGFloat = 16
            static let height: CGFloat = 74
            static let alignment: NSTextAlignment = .center
            static let datePickerFrame: CGRect = CGRect(x: 0, y: 0, width: 402, height: 520)
        }
    }
    
    // MARK: - Variables
    weak var delegate: WishEventCreationViewDelegate?
    
    // MARK: - Private fields
    private let add: UIButton = UIButton(type: Constants.Buttons.type)
    private let cancelButton: UIButton = UIButton(type: Constants.Buttons.type)
    private let titleTextField: CustomTextField = CustomTextField(
        title: Constants.TitleTextField.title,
        placeholder: Constants.TitleTextField.placeholder
    )
    private let descriptionTextField: CustomTextField = CustomTextField(
        title: Constants.DescritionTextField.title,
        placeholder: Constants.DescritionTextField.placeholder
    )
    private let startDateTextField: CustomTextField = CustomTextField(
        title: Constants.StartDateTextField.title,
        placeholder: Constants.StartDateTextField.placeholder,
        alignment: Constants.StartDateTextField.alignment
    )
    private let endDateTextField: CustomTextField = CustomTextField(
        title: Constants.EndDateTextField.title,
        placeholder: Constants.EndDateTextField.placeholder,
        alignment: Constants.EndDateTextField.alignment
    )
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = Constants.View.backgroundColor
        setUpButtons()
        setUpTitleTextField()
        setUpDescriptionTextField()
        setUpStartDateTextField()
        setUpEndDateTextField()
    }
    
    private func setUpButtons() {
        for button in [cancelButton, add] {
            button.backgroundColor = Constants.Buttons.backgroundColor
            button.titleLabel?.font = Constants.Buttons.font
            button.setTitleColor(Constants.Buttons.titleColor, for: Constants.Buttons.stateTitleColor)
        }
        
        add.setTitle(Constants.Buttons.doneTitle, for: Constants.Buttons.stateTitle)
        add.addTarget(self, action: #selector(addButtonTapped), for: Constants.Buttons.event)
        cancelButton.setTitle(Constants.Buttons.cancelTitle, for: Constants.Buttons.stateTitle)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: Constants.Buttons.event)
        
        addSubview(cancelButton)
        cancelButton.pinTop(to: self, Constants.Buttons.top)
        cancelButton.pinLeft(to: self, Constants.Buttons.cancelLeft)
        cancelButton.setHeight(Constants.Buttons.height)
        cancelButton.setWidth(Constants.Buttons.width)
        
        addSubview(add)
        add.pinTop(to: self, Constants.Buttons.top)
        add.pinRight(to: self, Constants.Buttons.addRight)
        add.setHeight(Constants.Buttons.height)
        add.setWidth(Constants.Buttons.width)
    }
    
    private func setUpTitleTextField() {
        addSubview(titleTextField)
        titleTextField.pinTop(to: add.bottomAnchor, Constants.TitleTextField.top)
        titleTextField.pinHorizontal(to: self, Constants.TitleTextField.horizontalOffset)
        titleTextField.setHeight(Constants.TitleTextField.height)
    }
    
    private func setUpDescriptionTextField() {
        addSubview(descriptionTextField)
        descriptionTextField.pinTop(to: titleTextField.bottomAnchor, Constants.DescritionTextField.top)
        descriptionTextField.pinHorizontal(to: self, Constants.DescritionTextField.horizontalOffset)
        descriptionTextField.setHeight(Constants.DescritionTextField.height)
    }
    
    private func setUpStartDateTextField() {
        let datePicker: CustomDatePicker = CustomDatePicker(frame: Constants.StartDateTextField.datePickerFrame)
        datePicker.cancelAction = { [weak self] in
            self?.startDateTextField.closeResponder()
        }
        
        datePicker.doneAction = { [weak self] in
            self?.startDateTextField.setDate(datePicker.getDate())
            self?.startDateTextField.closeResponder()
        }
        
        startDateTextField.setInputView(datePicker)
        
        addSubview(startDateTextField)
        startDateTextField.pinTop(to: descriptionTextField.bottomAnchor, Constants.StartDateTextField.top)
        startDateTextField.pinHorizontal(to: self, Constants.StartDateTextField.horizontalOffset)
        startDateTextField.setHeight(Constants.StartDateTextField.height)
    }
    
    private func setUpEndDateTextField() {
        let datePicker: CustomDatePicker = CustomDatePicker(frame: Constants.EndDateTextField.datePickerFrame)
        datePicker.cancelAction = { [weak self] in
            self?.endDateTextField.closeResponder()
        }
        
        datePicker.doneAction = { [weak self] in
            self?.endDateTextField.setDate(datePicker.getDate())
            self?.endDateTextField.closeResponder()
        }
        
        endDateTextField.setInputView(datePicker)
        
        addSubview(endDateTextField)
        endDateTextField.pinTop(to: startDateTextField.bottomAnchor, Constants.EndDateTextField.top)
        endDateTextField.pinHorizontal(to: self, Constants.EndDateTextField.horizontalOffset)
        endDateTextField.setHeight(Constants.EndDateTextField.height)
    }
    
    // MARK: - Actions
    @objc
    private func cancelButtonTapped() {
        delegate?.goBackScreen()
    }
    
    @objc
    private func addButtonTapped() {
        if let title = titleTextField.getText(),
           let description = descriptionTextField.getText(),
           let startDate = startDateTextField.getText(),
           let endDate = endDateTextField.getText()
        {
            delegate?.createWishEvent(
                WishEvent(
                    title: title,
                    description: description,
                    startDate: startDate,
                    endDate: endDate
                )
            )
            delegate?.goBackScreen()
        }
    }
}
