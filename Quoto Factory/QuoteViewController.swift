//
//  QuoteViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    // MARK: variables
    var newQuoto: NewQuoto!
    
    // MARK: IBOutlets
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var patienceButton: UIButton!
    @IBOutlet weak var luckButton: UIButton!
    @IBOutlet weak var successButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var friendsButton: UIButton!
    @IBOutlet weak var ambitionButton: UIButton!
    @IBOutlet weak var careerButton: UIButton!
    @IBOutlet weak var literatureButton: UIButton!
    @IBOutlet weak var philosophyButton: UIButton!
    @IBOutlet weak var motivationalButton: UIButton!
    @IBOutlet weak var adversityButton: UIButton!
    @IBOutlet weak var wisdomButton: UIButton!
    @IBOutlet weak var memoriesButton: UIButton!
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var artButton: UIButton!
    @IBOutlet weak var funnyButton: UIButton!
    @IBOutlet weak var inspirationalButton: UIButton!
    @IBOutlet weak var lifeButton: UIButton!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var sportsButton: UIButton!
    @IBOutlet weak var managementButton: UIButton!
    @IBOutlet weak var angerButton: UIButton!
    @IBOutlet weak var strengthButton: UIButton!
    
    @IBOutlet var genericButton: [UIButton]!
    
    @IBOutlet var buttonLeft: [UIButton]!
    @IBOutlet var buttonRight: [UIButton]!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI setup
        for button in self.genericButton {
            button.layer.cornerRadius = 15
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: IBActions
    @IBAction func getQuote(_ sender: UIButton) {
        self.newQuoto.quotoCategory = sender.titleLabel!.text!
        self.performSegue(withIdentifier: "segueToQuoteDetailVC", sender: self)
    }


    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToQuoteDetailVC" {
        let controller = segue.destination as! QuoteDetailViewController
            controller.newQuoto = self.newQuoto
        }
    }


}
