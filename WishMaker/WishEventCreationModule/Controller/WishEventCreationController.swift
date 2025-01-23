//
//  WishEventCreationController.swift
//  WishMaker
//
//  Created by Peter on 23.01.2025.
//

import Foundation
import UIKit

final class WishEventCreationController: UIViewController {
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
        navigationController?.popViewController(animated: true)
    }
}
