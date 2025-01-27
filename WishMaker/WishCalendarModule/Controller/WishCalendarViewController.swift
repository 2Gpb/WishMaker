//
//  WishCalendarViewControlle.swift
//  HomeWork2
//
//  Created by Peter on 01.12.2024.
//
import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Variables
    var events: [CalendarEventModel] = [CalendarEventModel(
        title: "I want to finish the layout in Figma.",
        description: "I want to finish the layout in figma of an application I'm going to write for my diploma.",
        startDate: Date(),
        endDate: Date()
    )]
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        let vc = WishCalendarView()
        vc.delegate = self
        view = vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
    }
    // MARK: - Private methods
    private func setUpNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - WishCalendarViewDelegate
extension WishCalendarViewController: WishCalendarViewDelegate {
    func createEvent() {
        let vc = WishEventCreationController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func goBackScreen() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - WishEventCreationDelegate
extension WishCalendarViewController: WishEventCreationDelegate {
    func addEvent(_ event: CalendarEventModel) {
        events.append(event)
        if let calendarView = view as? WishCalendarView {
            calendarView.reloadTable()
        }
    }
}
