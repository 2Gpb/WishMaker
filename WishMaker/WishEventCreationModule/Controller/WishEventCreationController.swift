//
//  WishEventCreationController.swift
//  WishMaker
//
//  Created by Peter on 23.01.2025.
//

import Foundation
import UIKit

protocol WishEventCreationDelegate: AnyObject {
    func addEvent(_ event: WishEvent)
}

final class WishEventCreationController: UIViewController {
    // MARK: - Variables
    weak var delegate: WishEventCreationDelegate?
    
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
    
    func createWishEvent(_ event: WishEvent) {
        delegate?.addEvent(event)
    }
}
