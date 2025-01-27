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
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum Cell {
            static let backgroundColor: UIColor = .cells
            static let radius: CGFloat = 20
            static let curve: CALayerCornerCurve = .continuous
        }
        
        enum StartDateLabel {
            static let text: String = "Start Date: "
            static let fontSize: CGFloat = 14
            static let fontWeight: UIFont.Weight = .regular
            static let textColor: UIColor = .lightGray
            static let top: Double = 20
            static let leading: Double = 20
        }
        
        enum EndDateLabel {
            static let text: String = "End Date: "
            static let fontSize: CGFloat = 14
            static let fontWeight: UIFont.Weight = .regular
            static let textColor: UIColor = .lightGray
            static let top: Double = 6
            static let leading: Double = 20
        }
        
        enum TitleLabel {
            static let fontSize: CGFloat = 17
            static let fontWeight: UIFont.Weight = .bold
            static let textColor: UIColor = .white
            static let numberOfLines: Int = 1
            static let top: Double = 20
            static let leading: Double = 20
            static let trailing: Double = 20
        }
        
        enum DescriptionLabel {
            static let fontSize: CGFloat = 14
            static let fontWeight: UIFont.Weight = .regular
            static let textColor: UIColor = .white
            static let numberOfLines: Int = 2
            static let top: Double = 8
            static let leading: Double = 20
            static let trailing: Double = 20
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
    public func configure(with event: CalendarEventModel) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, dd.MM.yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone.current
        
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = Constants.StartDateLabel.text + formatter.string(from: event.startDate)
        endDateLabel.text = Constants.EndDateLabel.text + formatter.string(from: event.endDate)
    }
    
    // MARK: - SetUp
    private func setUp() {
        backgroundColor = Constants.Cell.backgroundColor
        layer.cornerRadius = Constants.Cell.radius
        layer.cornerCurve = Constants.Cell.curve
        
        setUpStartDateLabel()
        setUpEndDateLabel()
        setUpTitleLabel()
        setUpDescription()
    }
    
    private func setUpStartDateLabel() {
        startDateLabel.font = 
            .systemFont(
            ofSize: Constants.StartDateLabel.fontSize,
            weight: Constants.StartDateLabel.fontWeight
        )
        startDateLabel.textColor = Constants.StartDateLabel.textColor
        
        addSubview(startDateLabel)
        startDateLabel.pinTop(to: self, Constants.StartDateLabel.top)
        startDateLabel.pinLeft(to: self.leadingAnchor, Constants.StartDateLabel.leading)
    }
    
    private func setUpEndDateLabel() {
        endDateLabel.font = 
            .systemFont(
            ofSize: Constants.EndDateLabel.fontSize,
            weight: Constants.EndDateLabel.fontWeight
        )
        endDateLabel.textColor = Constants.EndDateLabel.textColor
        
        addSubview(endDateLabel)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.EndDateLabel.top)
        endDateLabel.pinLeft(to: self.leadingAnchor, Constants.EndDateLabel.leading)
    }
    
    private func setUpTitleLabel() {
        titleLabel.font = 
            .systemFont(
                ofSize: Constants.TitleLabel.fontSize,
                weight: Constants.TitleLabel.fontWeight
            )
        titleLabel.textColor = Constants.TitleLabel.textColor
        titleLabel.numberOfLines = Constants.TitleLabel.numberOfLines
        
        addSubview(titleLabel)
        titleLabel.pinTop(to: endDateLabel.bottomAnchor, Constants.TitleLabel.top)
        titleLabel.pinLeft(to: self, Constants.TitleLabel.leading)
        titleLabel.pinRight(to: self, Constants.TitleLabel.trailing)
    }
    
    private func setUpDescription() {
        descriptionLabel.font =
            .systemFont(
                ofSize: Constants.DescriptionLabel.fontSize,
                weight: Constants.DescriptionLabel.fontWeight
            )
        descriptionLabel.textColor = Constants.DescriptionLabel.textColor
        descriptionLabel.numberOfLines = Constants.DescriptionLabel.numberOfLines
        
        addSubview(descriptionLabel)
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.DescriptionLabel.top)
        descriptionLabel.pinLeft(to: self, Constants.DescriptionLabel.leading)
        descriptionLabel.pinRight(to: self, Constants.DescriptionLabel.trailing)
    }
}
