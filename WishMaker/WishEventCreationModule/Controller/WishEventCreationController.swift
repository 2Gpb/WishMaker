//
//  WishEventCreationController.swift
//  WishMaker
//
//  Created by Peter on 23.01.2025.
//

import Foundation
import UIKit

protocol WishEventCreationDelegate: AnyObject {
    func addEvent(_ event: CalendarEventModel)
}

final class WishEventCreationController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        static let errorAdditionEvent: String = "Failed to create event in calendar"
        static let error: String = "init(coder:) has not been implemented"
    }
    
    // MARK: - Variables
    weak var delegate: WishEventCreationDelegate?
    
    // MARK: - Private fields
    private var wishEventCreationView: WishEventCreationView?
    private let calendar: CalendarManaging = CalendarManager()
    
    // MARK: - Lifecycle
    init(delegate: WishEventCreationDelegate, color: UIColor?) {
        super.init(nibName: nil, bundle: nil)
        wishEventCreationView = WishEventCreationView(delegate: self, color: color)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.error)
    }
    
    override func loadView() {
        super.loadView()
        view = wishEventCreationView
    }
}

// MARK: - WishEventCreationViewDelegate
extension WishEventCreationController: WishEventCreationViewDelegate {
    func goBackScreen() {
        dismiss(animated: true)
    }
    
    func createWishEvent(_ event: CalendarEventModel) {
        delegate?.addEvent(event)
        guard calendar.create(eventModel: event) else {
            print(Constants.errorAdditionEvent)
            return
        }
        
        dismiss(animated: true)
    }
    
    func presentWishesAlert(_ alert: UIAlertController) {
        present(alert, animated: true)
    }
}
