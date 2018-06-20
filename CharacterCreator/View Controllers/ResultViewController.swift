//
//  ResultViewController.swift
//  CharacterCreator
//
//  Created by Ike Mattice on 6/19/18.
//  Copyright © 2018 Ike Mattice. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
	@IBOutlet weak var descriptionLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

		descriptionLabel.text = """
		Level 1 \(String(describing: Character.current.race)) \(String(describing: Character.current.class)) with
		\(Character.current.stats.str) Strength
		\(Character.current.stats.con) Constitution
		\(Character.current.stats.dex) Dexterity
		\(Character.current.stats.cha) Charisma
		\(Character.current.stats.wis) Wisdom
		\(Character.current.stats.int) Intelligence

		Great job!
"""
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
