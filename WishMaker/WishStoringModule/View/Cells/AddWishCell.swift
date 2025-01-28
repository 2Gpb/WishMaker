//
//  AddWishCell.swift
//  HomeWork2
//
//  Created by Peter on 25.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum ReuseIdentifier {
            static let value: String = "AddWishCell"
        }
        
        enum Cell {
            static let backgroundColor: UIColor = .clear
        }
        
        enum AddWishButton {
            static let title: String = "Add"
            static let state: UIControl.State = .normal
            static let titleColor: UIColor = .white
            static let fontSize: CGFloat = 12
            static let fontWeight: UIFont.Weight = .bold
            static let cornerRadius: CGFloat = 14
            static let borderWidth: CGFloat = 2
            static let borderColor: CGColor = UIColor.white.cgColor
            static let event: UIControl.Event = .touchUpInside
            static let offset: CGFloat = 0
            static let right: CGFloat = 0
            static let width: CGFloat = 60
        }
        
        enum TextView {
            static let fontSize: CGFloat = 17
            static let fontWeight: UIFont.Weight = .regular
            static let cornerRadius: CGFloat = 14
            static let borderWidth: CGFloat = 1
            static let backgroundColor: UIColor = .lightGray
            static let offset: CGFloat = 0
            static let left: CGFloat = 0
            static let right: CGFloat = 5
            static let textColor: UIColor = .black
            static let insets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 8, bottom: 0, right: 9)
        }
    }
    
    // MARK: - ReuseId
    static let reuseId: String = Constants.ReuseIdentifier.value
    
    // MARK: - Variables
    var addWish: ((String) -> ())?
    
    // MARK: - Private fields
    private let addWishButton: UIButton = UIButton(type: .system)
    private let textView: UITextView = UITextView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = Constants.Cell.backgroundColor
        
        setUpAddWishButton()
        setUpTextView()
    }
    
    private func setUpAddWishButton() {
        addWishButton.setTitle(Constants.AddWishButton.title, for: Constants.AddWishButton.state)
        addWishButton.setTitleColor(Constants.AddWishButton.titleColor, for: Constants.AddWishButton.state)
        addWishButton.titleLabel?.font = UIFont
            .systemFont(
                ofSize: Constants.AddWishButton.fontSize,
                weight: Constants.AddWishButton.fontWeight
            )
        addWishButton.layer.cornerRadius = Constants.AddWishButton.cornerRadius
        addWishButton.layer.borderWidth = Constants.AddWishButton.borderWidth
        addWishButton.layer.borderColor = Constants.AddWishButton.borderColor
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: Constants.AddWishButton.event)
        
        contentView.addSubview(addWishButton)
        addWishButton.pinRight(to: trailingAnchor, Constants.AddWishButton.right)
        addWishButton.pinTop(to: topAnchor, Constants.AddWishButton.offset)
        addWishButton.pinBottom(to: bottomAnchor, Constants.AddWishButton.offset)
        addWishButton.setWidth(Constants.AddWishButton.width)
    }
    
    private func setUpTextView() {
        textView.font = UIFont
            .systemFont(
                ofSize: Constants.TextView.fontSize,
                weight: Constants.TextView.fontWeight
            )
        
        textView.layer.cornerRadius = Constants.TextView.cornerRadius
        textView.layer.borderWidth = Constants.TextView.borderWidth
        textView.backgroundColor = Constants.TextView.backgroundColor
        textView.textColor = Constants.TextView.textColor
        textView.textContainerInset = Constants.TextView.insets
        
        contentView.addSubview(textView)
        textView.pinLeft(to: leadingAnchor, Constants.TextView.left)
        textView.pinRight(to: addWishButton.leadingAnchor, Constants.TextView.right)
        textView.pinVertical(to: self, Constants.TextView.offset)
    }
    
    // MARK: - Actions
    @objc
    private func addWishButtonTapped() {
        addWish?(textView.text)
        textView.text = ""
    }
}
