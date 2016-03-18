//
//  QuoteViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class QuoteViewController: UIViewController {
    
    var newQuoto: NewQuoto!
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 242/255, green: 46/255, blue: 70/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Futura-CondensedExtraBold", size: 24)!]
        
        for button in self.genericButton {
            button.layer.cornerRadius = 15
        }
        
        for button in self.buttonLeft {
            button.center = CGPointMake(button.center.x - 500, button.center.y)
        }
        
        for button in self.buttonRight {
            button.center = CGPointMake(button.center.x + 500, button.center.y)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.animateButton(0.2, button: angerButton, direction: 500)
        self.animateButton(0.2, button: strengthButton, direction: -500)
        self.animateButton(0.4, button: sportsButton, direction: 500)
        self.animateButton(0.4, button: managementButton, direction: -500)
        self.animateButton(0.6, button: lifeButton, direction: 500)
        self.animateButton(0.6, button: loveButton, direction: -500)
        self.animateButton(0.8, button: funnyButton, direction: 500)
        self.animateButton(0.8, button: inspirationalButton, direction: -500)
        self.animateButton(1.0, button: randomButton, direction: 500)
        self.animateButton(1.0, button: artButton, direction: -500)
        self.animateButton(1.2, button: wisdomButton, direction: 500)
        self.animateButton(1.2, button: memoriesButton, direction: -500)
        self.animateButton(1.4, button: motivationalButton, direction: 500)
        self.animateButton(1.4, button: adversityButton, direction: -500)
        self.animateButton(1.6, button: literatureButton, direction: 500)
        self.animateButton(1.6, button: philosophyButton, direction: -500)
        self.animateButton(1.8, button: ambitionButton, direction: 500)
        self.animateButton(1.8, button: careerButton, direction: -500)
        self.animateButton(2.0, button: familyButton, direction: 500)
        self.animateButton(2.0, button: friendsButton, direction: -500)
        self.animateButton(2.2, button: luckButton, direction: 500)
        self.animateButton(2.2, button: successButton, direction: -500)
        self.animateButton(2.4, button: challengeButton, direction: 500)
        self.animateButton(2.4, button: patienceButton, direction: -500)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func animateButton(duration: Double, button: UIButton, direction: CGFloat) {
        UIView.animateWithDuration(duration, animations: { () -> Void in
            button.center = CGPointMake(button.center.x + direction, button.center.y)
            
        })
    }
    
    @IBAction func getQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = sender.titleLabel!.text!
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }


    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToQuoteDetailVC" {
        let controller = segue.destinationViewController as! QuoteDetailViewController
            controller.newQuoto = self.newQuoto
        }
    }


}
