//
//  WrittenWishCell.swift
//  HomeWork2
//
//  Created by Peter on 25.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum ReuseIdentifier {
            static let value: String = "WrittenWishCell"
        }
        
        enum Cell {
            static let style: UITableViewCell.SelectionStyle = .none
            static let backgroundColor: UIColor = .clear
        }
        
        enum Wrap {
            static let backgroundColor: UIColor = .cells
            static let cornerRadius: CGFloat = 12
            static let offsetV: CGFloat = 5
            static let trailing: CGFloat = 5
            static let leading: CGFloat = 16
        }
        
        enum WishLabel {
            static let alignment: NSTextAlignment = .center
            static let textColor: UIColor = .white
            static let fontSize: CGFloat = 17
            static let fontWeight: UIFont.Weight = .bold
            static let offset: CGFloat = 8
        }
    }
    
    // MARK: - ReuseId
    static let reuseId: String = Constants.ReuseIdentifier.value
    
    // MARK: - Private fields
    private let wrap: UIView = UIView()
    private let wishLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - Methods
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - SetUp
    private func setUp() {
        selectionStyle = Constants.Cell.style
        backgroundColor = Constants.Cell.backgroundColor
        
        setUpWrap()
        setUpWishLabel()
    }
    
    private func setUpWrap() {
        wrap.backgroundColor = Constants.Wrap.backgroundColor
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        
        addSubview(wrap)
        wrap.pinVertical(to: self, Constants.Wrap.offsetV)
        wrap.pinRight(to: self.trailingAnchor, Constants.Wrap.trailing)
        wrap.pinLeft(to: self.leadingAnchor, Constants.Wrap.leading)
    }
    
    private func setUpWishLabel() {
        wishLabel.textAlignment = Constants.WishLabel.alignment
        wishLabel.textColor = Constants.WishLabel.textColor
        wishLabel.font =
            .systemFont(
                ofSize: Constants.WishLabel.fontSize,
                weight: Constants.WishLabel.fontWeight
        )
        wrap.addSubview(wishLabel)
        wishLabel.pin(to: wrap, Constants.WishLabel.offset)
    }
}
