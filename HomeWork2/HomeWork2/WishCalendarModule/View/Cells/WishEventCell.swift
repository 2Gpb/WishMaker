//
//  WishEventCell.swift
//  HomeWork2
//
//  Created by Peter on 03.12.2024.
//
import UIKit

final class WishEventCell: UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError = "init(coder:) has not been implemented"
        }
    }
    // MARK: - ReuseID
    static let reuseId = "WishEventCell"
    
    // MARK: - Private fields
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
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
    func configure(with event: WishEvent) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = .gray
        layer.cornerRadius = 20
        setUpTitleLabel()
        setUpDescription()
        setUpStartDateLabel()
        setUpEndDateLabel()
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.textColor = .white
        
        addSubview(titleLabel)
        titleLabel.pinTop(to: self, 20)
        titleLabel.pinLeft(to: self, 20)
    }
    
    private func setUpDescription() {
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .white
        
        addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, 8)
        descriptionLabel.pinLeft(to: self, 20)
    }
    
    private func setUpStartDateLabel() {
        startDateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        startDateLabel.textColor = .lightGray
        
        addSubview(startDateLabel)
        startDateLabel.pinTop(to: self, 20)
        startDateLabel.pinRight(to: self.trailingAnchor, 20)
    }
    
    private func setUpEndDateLabel() {
        endDateLabel.font = .systemFont(ofSize: 14, weight: .regular)
        endDateLabel.textColor = .lightGray
        
        addSubview(endDateLabel)
        endDateLabel.pinTop(to: descriptionLabel.topAnchor)
        endDateLabel.pinRight(to: self.trailingAnchor, 20)
    }
}
