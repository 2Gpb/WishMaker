//
//  CustomTextField.swift
//  WishMaker
//
//  Created by Peter on 24.01.2025.
//

import Foundation
import UIKit

final class CustomTextField: UIView {
    // MARK: Constants
    private enum Constants {
        enum Error {
            static let fatalError = "init(coder:) has not been implemented"
        }
        
        enum Formatter {
            static let dateStyle: DateFormatter.Style = .long
            static let timeStyle: DateFormatter.Style = .short
            static let locale: Locale = Locale(identifier: "en_EN")
        }
        
        enum TitleLabel {
            static let font: UIFont = .systemFont(ofSize: 14, weight: .light)
            static let textColor: UIColor = .lightGray
            static let numberOfLines: Int = 1
        }
        
        enum TextField {
            static let placeholderAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray
            ]
            static let backgroundColor: UIColor = .clear
            static let font: UIFont = .systemFont(ofSize: 17, weight: .regular)
            static let textColor: UIColor = .white
            static let alignment: NSTextAlignment = .left
            static let cornerRadius: CGFloat = 16
            static let borderWidth: CGFloat = 1
            static let borderColor: CGColor = UIColor.lightGray.cgColor
            static let top: CGFloat = 8
            static let height: CGFloat = 48
        }
        
        enum OffsetView {
            static let x: CGFloat = 0
            static let y: CGFloat = 0
            static let width: CGFloat = 12
            static let height: CGFloat = 1
        }
    }
    
    // MARK: - Private fields
    private let titleLabel: UILabel = UILabel()
    private let textField: UITextField = UITextField()
    private let offsetView: UIView = UIView(
        frame: CGRect(
            x: Constants.OffsetView.x,
            y: Constants.OffsetView.y,
            width: Constants.OffsetView.width,
            height: Constants.OffsetView.height
        )
    )
    
    // MARK: - Lifecycle
    init(title: String, placeholder: String, alignment: NSTextAlignment = Constants.TextField.alignment) {
        super.init(frame: .zero)
        titleLabel.text = title
        textField.textAlignment = alignment
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: Constants.TextField.placeholderAttributes
        )
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - Methods
    public func setInputView(_ inputView: UIView?) {
        textField.inputView = inputView
    }
    
    public func closeResponder() {
        textField.resignFirstResponder()
    }
    
    public func setDate(_ date: Date) {
        let formatter = DateFormatter()
        formatter.dateStyle = Constants.Formatter.dateStyle
        formatter.timeStyle = Constants.Formatter.timeStyle
        formatter.locale = Constants.Formatter.locale
        textField.text = formatter.string(from: date)
    }
    
    public func getText() -> String? {
        return textField.text
    }
    
    // MARK: - SetUp
    private func setUp() {
        setUpTitle()
        setUpTextField()
    }
    
    private func setUpTitle() {
        titleLabel.font = Constants.TitleLabel.font
        titleLabel.textColor = Constants.TitleLabel.textColor
        titleLabel.numberOfLines = Constants.TitleLabel.numberOfLines
        
        addSubview(titleLabel)
        titleLabel.pinTop(to: self)
        titleLabel.pinLeft(to: self)
    }
    
    private func setUpTextField() {
        textField.backgroundColor = Constants.TextField.backgroundColor
        textField.textColor = Constants.TextField.textColor
        textField.font = Constants.TextField.font
        textField.layer.cornerRadius = Constants.TextField.cornerRadius
        textField.layer.borderWidth = Constants.TextField.borderWidth
        textField.layer.borderColor = Constants.TextField.borderColor
        textField.leftView = offsetView
        textField.rightView = offsetView
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        
        addSubview(textField)
        textField.pinTop(to: titleLabel.bottomAnchor, Constants.TextField.top)
        textField.pinHorizontal(to: self)
        textField.setHeight(Constants.TextField.height)
    }
}
