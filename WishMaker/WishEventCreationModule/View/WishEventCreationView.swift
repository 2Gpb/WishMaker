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
    func createWishEvent(_ event: CalendarEventModel)
    func presentWishesAlert(_ alert: UIAlertController)
}

final class WishEventCreationView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
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
            static let horizontal: CGFloat = 16
            static let height: CGFloat = 74
        }
        
        enum WishListButton {
            static let type: UIButton.ButtonType = .system
            static let image: UIImage? = UIImage(systemName: "list.bullet")
            static let state: UIControl.State = .normal
            static let color: UIColor = .white
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 60
            static let right: CGFloat = 16
            static let width: CGFloat = 30
            static let height: CGFloat = 30
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
        
        enum WishPicker {
            static let numberOfComponents = 1
            static let alertTitle = "Select from yours wishes:"
            static let alertMessage: String? = nil
            static let alertStyle: UIAlertController.Style = .actionSheet
            static let alertHeight: CGFloat = 380
            static let interfce: UIUserInterfaceStyle = .dark
            static let wrapViewColor: UIColor = .clear
            static let wrapViewTop: CGFloat = 40
            static let wrapViewHeight: CGFloat = 200
            static let wrapViewHorizontalOffsets: CGFloat = 40
            static let xPicker: CGFloat = 0
            static let yPicker: CGFloat = 0
            static let pickerHorizontalOffsets: CGFloat = 40
            static let pickerHeight: CGFloat = 220
            static let pickerCancelTitle: String = "Cancel"
            static let pickerCancelStyle: UIAlertAction.Style = .cancel
            static let pickerCancelHandler: ((UIAlertAction) -> Void)? = nil
            static let pickerDoneTitle: String = "Select"
            static let pickerDoneStyle: UIAlertAction.Style = .default
            static let inComponent: Int = 0
        }
    }
    
    // MARK: - Variables
    weak var delegate: WishEventCreationViewDelegate?
    
    // MARK: - Private fields
    private let add: UIButton = UIButton(type: Constants.Buttons.type)
    private let cancelButton: UIButton = UIButton(type: Constants.Buttons.type)
    private let wishListButton: UIButton = UIButton(type: Constants.WishListButton.type)
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
    init(delegate: WishEventCreationViewDelegate, color: UIColor?) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.backgroundColor = color
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    private func setUp() {
        setUpButtons()
        setUpWishListButton()
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
    
    private func setUpWishListButton() {
        wishListButton.setImage(Constants.WishListButton.image, for: Constants.WishListButton.state)
        wishListButton.tintColor = Constants.WishListButton.color
        wishListButton.addTarget(self, action: #selector(wishListButtonTapped), for: Constants.WishListButton.event)
        
        addSubview(wishListButton)
        wishListButton.pinTop(to: add.bottomAnchor, Constants.WishListButton.top)
        wishListButton.pinRight(to: self, Constants.WishListButton.right)
        wishListButton.setHeight(Constants.WishListButton.height)
        wishListButton.setWidth(Constants.WishListButton.width)
    }
    
    private func setUpTitleTextField() {
        addSubview(titleTextField)
        titleTextField.pinTop(to: add.bottomAnchor, Constants.TitleTextField.top)
        titleTextField.pinLeft(to: self, Constants.TitleTextField.horizontal)
        titleTextField.pinRight(to: wishListButton.leadingAnchor, Constants.TitleTextField.horizontal)
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
           let startDate = startDateTextField.getDate(),
           let endDate = endDateTextField.getDate()
        {
            delegate?.createWishEvent(
                CalendarEventModel(
                    title: title,
                    description: description,
                    startDate: startDate,
                    endDate: endDate
                )
            )
        }
        delegate?.goBackScreen()
    }
    
    @objc
    private func wishListButtonTapped() {
        let alert = UIAlertController(
            title: Constants.WishPicker.alertTitle,
            message: Constants.WishPicker.alertMessage,
            preferredStyle: Constants.WishPicker.alertStyle
        )
        
        alert.view.setHeight(Constants.WishPicker.alertHeight)
        alert.overrideUserInterfaceStyle = Constants.WishPicker.interfce
        
        let wrapView = UIView()
        wrapView.backgroundColor = Constants.WishPicker.wrapViewColor
        
        alert.view.addSubview(wrapView)
        wrapView.pinTop(to: alert.view, Constants.WishPicker.wrapViewTop)
        wrapView.pinCenterX(to: alert.view)
        wrapView.setWidth(self.bounds.width - Constants.WishPicker.wrapViewHorizontalOffsets)
        wrapView.setHeight(Constants.WishPicker.wrapViewHeight)
        
        let picker = UIPickerView(
            frame: CGRect(
                x: Constants.WishPicker.xPicker,
                y: Constants.WishPicker.yPicker,
                width: self.bounds.width - Constants.WishPicker.pickerHorizontalOffsets,
                height: Constants.WishPicker.pickerHeight
            )
        )
        
        picker.delegate = self
        picker.dataSource = self
        wrapView.addSubview(picker)
        
        let cancelAction = UIAlertAction(
            title: Constants.WishPicker.pickerCancelTitle,
            style: Constants.WishPicker.pickerCancelStyle,
            handler: Constants.WishPicker.pickerCancelHandler
        )
        
        let selectAction = UIAlertAction(
            title: Constants.WishPicker.pickerDoneTitle,
            style: Constants.WishPicker.pickerDoneStyle
        ) { _ in
            let selectedRow = picker.selectedRow(inComponent: Constants.WishPicker.inComponent)
            self.titleTextField.setText(WishCoreDataService.shared.getElement(selectedRow))
        }
        
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        delegate?.presentWishesAlert(alert)
    }
}

// MARK: - UIPickerViewDelegate
extension WishEventCreationView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let wishes = WishCoreDataService.shared.getElements()
        return wishes[row]
    }
}

// MARK: - UIPickerViewDataSource
extension WishEventCreationView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Constants.WishPicker.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let wishes = WishCoreDataService.shared.getElements()
        return wishes.count
    }
}
