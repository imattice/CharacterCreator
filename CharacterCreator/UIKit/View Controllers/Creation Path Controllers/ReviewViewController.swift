////
////  ReviewViewController.swift
////  CharacterCreator
////
////  Created by Ike Mattice on 6/19/18.
////  Copyright © 2018 Ike Mattice. All rights reserved.
////
//
//import UIKit
//
//class ReviewViewController: UIViewController {
//	@IBOutlet weak var tableView: UITableView!
//
//	var tableData = [TableData]()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//		loadTableData()
//
//		tableView.estimatedRowHeight = 100
//		tableView.rowHeight = UITableView.automaticDimension
//    }
//
//	private func loadTableData() {
//		for _ in 0...7 {
//			let data = TableData(isOpen: false)
//
//			tableData.append(data)
//		}
//	}
//	struct TableData {
//		var isOpen: Bool
//	}
//
//	@IBAction func printButtonTapped(_ sender: UITapGestureRecognizer) {
//		print("print this!")
//	}
//}
//
//extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
//	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//		if Character.current.spellBook.count > 0 {
//			return 8								}
//		return 7
//	}
//
//	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//		switch indexPath.row {
//		case 0: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.IdentityCell.rawValue) 		as! IdentityReviewTableViewCell
//		case 1: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.RaceCell.rawValue) 			as! RaceReviewTableViewCell
//		case 2: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ClassCell.rawValue) 		as! ClassReviewTableViewCell
//		case 3: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.BackgroundCell.rawValue) 	as! BackgroundReviewTableViewCell
//		case 4: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.StatCell.rawValue) 			as! StatReviewTableViewCell
//		case 5: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.SkillCell.rawValue) 		as! SkillReviewTableViewCell
//		case 6: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.InventoryCell.rawValue) 	as! InventoryReviewTableViewCell
//		case 7: return tableView.dequeueReusableCell(withIdentifier: CellIdentifier.SpellCell.rawValue) 		as! SpellReviewTableViewCell
//
//		default:
//			return UITableViewCell()
//		}
//	}
//
//	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		guard let cell = tableView.cellForRow(at: indexPath) as? ReviewTableViewCell else { return }
//		let data = tableData[indexPath.row]
//
//		tableView.beginUpdates()
//		cell.tapped(data.isOpen)
//		tableView.endUpdates()
//
//		tableData[indexPath.row].isOpen = !tableData[indexPath.row].isOpen
//
////		tableView.reloadRows(at: [indexPath], with: .fade)
//	}
//
//	enum CellIdentifier: String {
//		case IdentityCell, RaceCell, ClassCell, BackgroundCell, StatCell, SkillCell, InventoryCell, SpellCell
//	}
//}
