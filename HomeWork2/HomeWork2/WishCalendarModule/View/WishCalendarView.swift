//
//  WishCalendarView.swift
//  HomeWork2
//
//  Created by Peter on 03.12.2024.
//
import UIKit

final class WishCalendarView: UIView {
    // MARK: - Constants
    private enum Constants {
        enum Error {
            static let fatalError: String = "init(coder:) has not been implemented"
        }
        
        enum CollectionView {
            static let top: CGFloat = 20
            static let contentInset: UIEdgeInsets = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
        }
    }
    
    //MARK: - Private fields
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    
    // MARK: - Lifecycle
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.Error.fatalError)
    }
    
    // MARK: - SetUp
    func setUp() {
        backgroundColor = .systemCyan
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = Constants.CollectionView.contentInset
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        addSubview(collectionView)
        collectionView.pinTop(to: safeAreaLayoutGuide.topAnchor, Constants.CollectionView.top)
        collectionView.pinBottom(to: safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinHorizontal(to: self)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension WishCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: collectionView.bounds.width - 10, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Did select item at \(indexPath.item)")
    }
}

// MARK: - UICollectionViewDataSource
extension WishCalendarView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
}
