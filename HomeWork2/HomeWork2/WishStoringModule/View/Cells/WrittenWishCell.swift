//
//  WrittenWishCell.swift
//  HomeWork2
//
//  Created by Peter on 25.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - ReuseId
    static let reuseId: String = "WrittenWishCell"
    
    // MARK: - Constants
    private enum Constants {
        enum Wrap {
            static let cornerRadius: CGFloat = 12
            static let offsetV: CGFloat = 5
            static let trailing: CGFloat = 5
            static let leading: CGFloat = 16
        }
        
        enum WishLabel {
            static let offset: CGFloat = 8
        }
    }
    
    // MARK: - Private fields
    private let wishLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: - SetUp
    private func setUp() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        addSubview(wrap)
        
        wrap.backgroundColor = .white
        wrap.layer.cornerRadius = Constants.Wrap.cornerRadius
        wrap.pinVertical(to: self, Constants.Wrap.offsetV)
        wrap.pinRight(to: self.trailingAnchor, Constants.Wrap.trailing)
        wrap.pinLeft(to: self.leadingAnchor, Constants.Wrap.leading)
        
        wishLabel.textAlignment = .center
        wishLabel.font = .preferredFont(forTextStyle: .headline)
        
        wrap.addSubview(wishLabel)
        wishLabel.pin(to: wrap, Constants.WishLabel.offset)
    }
}
