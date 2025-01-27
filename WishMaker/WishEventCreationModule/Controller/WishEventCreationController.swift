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
        static let errorAdditionEvent = "Failed to create event in calendar"
    }
    
    // MARK: - Variables
    weak var delegate: WishEventCreationDelegate?
    
    // MARK: - Private fields
    private let calendar: CalendarManaging = CalendarManager()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        let vc = WishEventCreationView()
        vc.delegate = self
        view = vc
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
}
