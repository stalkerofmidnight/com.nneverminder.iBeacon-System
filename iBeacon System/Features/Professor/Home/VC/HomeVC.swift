//
//  HomeVC.swift
//  iBeacon System
//
//  Created by Ellan Esenaliev on 3/29/20.
//  Copyright © 2020 Anastasiya Ussenko. All rights reserved.
//

import UIKit
import FSCalendar

class HomeVC: BaseVC {
    
    @IBOutlet weak var calendarViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarView: FSCalendar! {
        didSet {
            calendarView.delegate = self
            calendarView.dataSource = self
            calendarView.calendarHeaderView.backgroundColor = Colors.white
            calendarView.calendarWeekdayView.backgroundColor = Colors.white
            calendarView.locale = Locale(identifier: "ru_RU")
            calendarView.firstWeekday = 2 // Monday
            calendarView.setScope(.week, animated: true)
            
            //Apearance
            calendarView.appearance.weekdayTextColor = Colors.darkGray
            calendarView.appearance.headerTitleColor = .black
            calendarView.appearance.headerTitleFont = UIFont.systemFont(ofSize: 14)
            calendarView.appearance.weekdayFont = UIFont.systemFont(ofSize: 10, weight: .medium)
            calendarView.appearance.headerMinimumDissolvedAlpha = 0
            calendarView.appearance.selectionColor = Colors.violet
            calendarView.appearance.headerDateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM YYYY", options: 0, locale: Locale(identifier: "ru_RU"))
            calendarView.appearance.caseOptions = [.headerUsesUpperCase, .weekdayUsesUpperCase]
            calendarView.appearance.todayColor = Colors.violet
            calendarView.appearance.borderRadius = 1.0
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.register(HomeTVCell.nib, forCellReuseIdentifier: HomeTVCell.identifier)
            tableView.separatorColor = Colors.mediumGray
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK:- FSCalendarDataSource
extension HomeVC: FSCalendarDataSource {
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: Date())!
    }
}
// MARK:- FSCalendarDelegate
extension HomeVC: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarViewHeightConstraint.constant = bounds.height
        view.layoutIfNeeded()
    }
}

extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTVCell.identifier) as! HomeTVCell
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    
}
