//
//  AddWishCell.swift
//  HomeWork2
//
//  Created by Peter on 25.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - ReuseId
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Constants
    private enum Constants {
        enum AddWishButton {
            static let title: String = "Add"
            static let fontSize: CGFloat = 12
            static let cornerRadius: CGFloat = 12
            static let borderWidth: CGFloat = 1
            static let offset: CGFloat = 5
            static let width: CGFloat = 60
        }
        
        enum TextView {
            static let cornerRadius: CGFloat = 12
            static let borderWidth: CGFloat = 1
            static let offset: CGFloat = 5
            static let leading: CGFloat = 16
        }
    }
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = .clear
        
        setUpAddWishButton()
        setUpTextView()
    }
    
    private func setUpAddWishButton() {
        addWishButton.setTitle(Constants.AddWishButton.title, for: .normal)
        addWishButton.setTitleColor(.black, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.AddWishButton.fontSize, weight: .bold)
        addWishButton.layer.cornerRadius = Constants.AddWishButton.cornerRadius
        addWishButton.layer.borderWidth = Constants.AddWishButton.borderWidth
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        
        contentView.addSubview(addWishButton)
        addWishButton.pinRight(to: trailingAnchor, Constants.AddWishButton.offset)
        addWishButton.pinTop(to: topAnchor, Constants.AddWishButton.offset)
        addWishButton.pinBottom(to: bottomAnchor, Constants.AddWishButton.offset)
        addWishButton.setWidth(Constants.AddWishButton.width)
    }
    
    private func setUpTextView() {
        textView.layer.cornerRadius = Constants.TextView.cornerRadius
        textView.layer.borderWidth = Constants.TextView.borderWidth
        textView.font = .preferredFont(forTextStyle: .callout)
        
        contentView.addSubview(textView)
        textView.pinLeft(to: leadingAnchor, Constants.TextView.leading)
        textView.pinRight(to: addWishButton.leadingAnchor, Constants.TextView.offset)
        textView.pinVertical(to: self, Constants.TextView.offset)
    }
    
    // MARK: - Actions
    @objc
    private func addWishButtonTapped() {
        addWish?(textView.text)
        textView.text = ""
    }
}
