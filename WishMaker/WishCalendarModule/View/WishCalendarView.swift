//
//  WishCalendarView.swift
//  HomeWork2
//
//  Created by Peter on 03.12.2024.
//
import UIKit

protocol WishCalendarViewDelegate: AnyObject {
    func goBackScreen()
    func createEvent()
    
    func getEvents() -> [CalendarEventModel]
    func getEvent(_ id: Int) -> CalendarEventModel
    func deleteEvent(id: Int)
}

final class WishCalendarView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum BackButton {
            static let image: UIImage = UIImage(systemName: "chevron.left") ?? UIImage()
            static let color: UIColor = .white
            static let state: UIControl.State = .normal
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 8
            static let leading: CGFloat = 10
            static let height: CGFloat = 30
            static let width: CGFloat = 30
            static let type: UIButton.ButtonType = .system
        }
        
        enum PlusButton {
            static let image: UIImage = UIImage(systemName: "plus") ?? UIImage()
            static let state: UIControl.State = .normal
            static let color: UIColor = .white
            static let event: UIControl.Event = .touchUpInside
            static let top: CGFloat = 8
            static let right: CGFloat = 10
            static let height: CGFloat = 30
            static let width: CGFloat = 30
            static let type: UIButton.ButtonType = .system
        }
        
        enum CollectionView {
            static let sectionInsets: UIEdgeInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
            static let defaultCell: CalendarEventModel = CalendarEventModel(
                title: "",
                description: "",
                startDate: Date(),
                endDate: Date()
            )
            
            static let backgroundColor: UIColor = .clear
            static let top: CGFloat = 20
            static let heightCell: CGFloat = 165
            static let totalIndent: CGFloat = 20
            static let lineSpacing: CGFloat = 15
        }
    }
    
    // MARK: - Variables
    weak var delegate: WishCalendarViewDelegate?
    
    //MARK: - Private fields
    private let backButton: UIButton = UIButton(type: Constants.BackButton.type)
    private let plusButton: UIButton = UIButton(type: Constants.PlusButton.type)
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Lifecycle
    init(delegate: WishCalendarViewDelegate, color: UIColor?) {
        super.init(frame: .zero)
        self.delegate = delegate
        self.backgroundColor = color
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - Methods
    func reloadTable() {
        collectionView.reloadData()
    }
    
    // MARK: - SetUp
    private func setUp() {
        setUpBackButton()
        setUpPlusButton()
        setUpCollectionView()
    }
    
    private func setUpBackButton() {
        backButton.setImage(Constants.BackButton.image, for: Constants.BackButton.state)
        backButton.tintColor = Constants.BackButton.color
        backButton.addTarget(self, action: #selector(goBackScreen), for: Constants.BackButton.event)

        addSubview(backButton)
        backButton.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.BackButton.top)
        backButton.pinLeft(to: safeAreaLayoutGuide.leadingAnchor, Constants.BackButton.leading)
        backButton.setHeight(Constants.BackButton.height)
        backButton.setWidth(Constants.BackButton.width)
    }
    
    private func setUpPlusButton() {
        plusButton.setImage(Constants.PlusButton.image, for: Constants.PlusButton.state)
        plusButton.tintColor = Constants.PlusButton.color
        plusButton.addTarget(self, action: #selector(createEvent), for: Constants.PlusButton.event)
        
        addSubview(plusButton)
        plusButton.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.PlusButton.top)
        plusButton.pinRight(to: safeAreaLayoutGuide.trailingAnchor, Constants.PlusButton.right)
        plusButton.setHeight(Constants.PlusButton.height)
        plusButton.setWidth(Constants.PlusButton.width)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Constants.CollectionView.backgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseId)
        
        addSubview(collectionView)
        collectionView.pinTop(to: backButton.bottomAnchor, Constants.CollectionView.top)
        collectionView.pinBottom(to: bottomAnchor)
        collectionView.pinHorizontal(to: self)
    }
    
    // MARK: - Actions
    @objc
    private func goBackScreen() {
        delegate?.goBackScreen()
    }
    
    @objc
    private func createEvent() {
        delegate?.createEvent()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: collectionView.bounds.width - Constants.CollectionView.totalIndent,
            height: Constants.CollectionView.heightCell
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Constants.CollectionView.lineSpacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return Constants.CollectionView.sectionInsets
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let events = delegate?.getEvents()
        return events?.count ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WishEventCell.reuseId,
            for: indexPath
        ) as? WishEventCell else {
            return UICollectionViewCell()
        }
        
        cell.onDelete = { [weak self] in
            self?.delegate?.deleteEvent(id: indexPath.row)
            self?.reloadTable()
        }
        
        let event = delegate?.getEvent(indexPath.row)
        cell.configure(with: event ?? Constants.CollectionView.defaultCell)
        return cell
    }
}
