//
//  WishCalendarViewControlle.swift
//  HomeWork2
//
//  Created by Peter on 01.12.2024.
//
import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Private fields
    private let wishCalendarView: WishCalendarView = WishCalendarView()
    private let wishEventCreationController: WishEventCreationController = WishEventCreationController()
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        wishCalendarView.delegate = self
        view = wishCalendarView
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
        wishEventCreationController.delegate = self
        present(wishEventCreationController, animated: true)
    }
    
    func goBackScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    func getEvents() -> [CalendarEventModel] {
        EventCoreDataService.shared.getElements()
    }
    
    func getEvent(_ id: Int) -> CalendarEventModel {
        EventCoreDataService.shared.getElement(id)
    }
    
    func deleteEvent(id: Int) {
        EventCoreDataService.shared.deleteElement(id: id)
    }
}

// MARK: - WishEventCreationDelegate
extension WishCalendarViewController: WishEventCreationDelegate {
    func addEvent(_ event: CalendarEventModel) {
        EventCoreDataService.shared.addElement(eventModel: event)
        wishCalendarView.reloadTable()
    }
}
