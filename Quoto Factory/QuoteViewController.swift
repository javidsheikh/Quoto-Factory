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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.challengeButton.center = CGPointMake(self.challengeButton.center.x - 500, self.challengeButton.center.y)
        self.patienceButton.center = CGPointMake(self.patienceButton.center.x + 500, self.patienceButton.center.y)
        self.luckButton.center = CGPointMake(self.luckButton.center.x - 500, self.luckButton.center.y)
        self.successButton.center = CGPointMake(self.successButton.center.x + 500, self.successButton.center.y)
        self.familyButton.center = CGPointMake(self.familyButton.center.x - 500, self.familyButton.center.y)
        self.friendsButton.center = CGPointMake(self.friendsButton.center.x + 500, self.friendsButton.center.y)
        self.ambitionButton.center = CGPointMake(self.ambitionButton.center.x - 500, self.ambitionButton.center.y)
        self.careerButton.center = CGPointMake(self.careerButton.center.x + 500, self.careerButton.center.y)
        self.literatureButton.center = CGPointMake(self.literatureButton.center.x - 500, self.literatureButton.center.y)
        self.philosophyButton.center = CGPointMake(self.philosophyButton.center.x + 500, self.philosophyButton.center.y)
        self.motivationalButton.center = CGPointMake(self.motivationalButton.center.x - 500, self.motivationalButton.center.y)
        self.adversityButton.center = CGPointMake(self.adversityButton.center.x + 500, self.adversityButton.center.y)
        self.wisdomButton.center = CGPointMake(self.wisdomButton.center.x - 500, self.wisdomButton.center.y)
        self.memoriesButton.center = CGPointMake(self.memoriesButton.center.x + 500, self.memoriesButton.center.y)
        self.randomButton.center = CGPointMake(self.randomButton.center.x - 500, self.randomButton.center.y)
        self.artButton.center = CGPointMake(self.artButton.center.x + 500, self.artButton.center.y)
        self.funnyButton.center = CGPointMake(self.funnyButton.center.x - 500, self.funnyButton.center.y)
        self.inspirationalButton.center = CGPointMake(self.inspirationalButton.center.x + 500, self.inspirationalButton.center.y)
        self.lifeButton.center = CGPointMake(self.lifeButton.center.x - 500, self.lifeButton.center.y)
        self.loveButton.center = CGPointMake(self.loveButton.center.x + 500, self.loveButton.center.y)
        self.sportsButton.center = CGPointMake(self.sportsButton.center.x - 500, self.sportsButton.center.y)
        self.managementButton.center = CGPointMake(self.managementButton.center.x + 500, self.successButton.center.y)
        self.angerButton.center = CGPointMake(self.angerButton.center.x - 500, self.angerButton.center.y)
        self.strengthButton.center = CGPointMake(self.strengthButton.center.x + 500, self.strengthButton.center.y)
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.angerButton.center = CGPointMake(self.angerButton.center.x + 500, self.angerButton.center.y)
            self.strengthButton.center = CGPointMake(self.strengthButton.center.x - 500, self.strengthButton.center.y)
            })
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.sportsButton.center = CGPointMake(self.sportsButton.center.x + 500, self.sportsButton.center.y)
            self.managementButton.center = CGPointMake(self.managementButton.center.x - 500, self.managementButton.center.y)
        })
        UIView.animateWithDuration(0.6, animations: { () -> Void in
            self.lifeButton.center = CGPointMake(self.lifeButton.center.x + 500, self.lifeButton.center.y)
            self.loveButton.center = CGPointMake(self.loveButton.center.x - 500, self.loveButton.center.y)
        })
        UIView.animateWithDuration(0.8, animations: { () -> Void in
            self.funnyButton.center = CGPointMake(self.funnyButton.center.x + 500, self.angerButton.center.y)
            self.inspirationalButton.center = CGPointMake(self.inspirationalButton.center.x - 500, self.strengthButton.center.y)
        })
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.randomButton.center = CGPointMake(self.randomButton.center.x + 500, self.randomButton.center.y)
            self.artButton.center = CGPointMake(self.artButton.center.x - 500, self.artButton.center.y)
        })
        UIView.animateWithDuration(1.2, animations: { () -> Void in
            self.wisdomButton.center = CGPointMake(self.wisdomButton.center.x + 500, self.wisdomButton.center.y)
            self.memoriesButton.center = CGPointMake(self.memoriesButton.center.x - 500, self.memoriesButton.center.y)
        })
        UIView.animateWithDuration(1.4, animations: { () -> Void in
            self.motivationalButton.center = CGPointMake(self.motivationalButton.center.x + 500, self.motivationalButton.center.y)
            self.adversityButton.center = CGPointMake(self.adversityButton.center.x - 500, self.adversityButton.center.y)
        })
        UIView.animateWithDuration(1.6, animations: { () -> Void in
            self.literatureButton.center = CGPointMake(self.literatureButton.center.x + 500, self.literatureButton.center.y)
            self.philosophyButton.center = CGPointMake(self.philosophyButton.center.x - 500, self.philosophyButton.center.y)
        })
        UIView.animateWithDuration(1.8, animations: { () -> Void in
            self.ambitionButton.center = CGPointMake(self.ambitionButton.center.x + 500, self.ambitionButton.center.y)
            self.careerButton.center = CGPointMake(self.careerButton.center.x - 500, self.careerButton.center.y)
        })
        UIView.animateWithDuration(2, animations: { () -> Void in
            self.familyButton.center = CGPointMake(self.familyButton.center.x + 500, self.familyButton.center.y)
            self.friendsButton.center = CGPointMake(self.friendsButton.center.x - 500, self.friendsButton.center.y)
        })
        UIView.animateWithDuration(2.2, animations: { () -> Void in
            self.luckButton.center = CGPointMake(self.luckButton.center.x + 500, self.luckButton.center.y)
            self.successButton.center = CGPointMake(self.successButton.center.x - 500, self.successButton.center.y)
        })
        UIView.animateWithDuration(2.4, animations: { () -> Void in
            self.challengeButton.center = CGPointMake(self.challengeButton.center.x + 500, self.challengeButton.center.y)
            self.patienceButton.center = CGPointMake(self.patienceButton.center.x - 500, self.patienceButton.center.y)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getChallengeQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "challenge"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getPatienceQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "patience"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    
    @IBAction func getLuckyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "lucky"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getSuccessQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "success"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getFamilyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "family"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getFriendsQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "friends"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getAmbitionQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "ambition"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getCareerQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "career"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getLiteratureQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "literature"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getPhilosophyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "philosophy"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getMotivationalQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "motivational"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getAdversityQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "adversity"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getWisdomQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "widsom"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getMemoriesQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "memories"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getRandom(sender: UIButton) {
        self.newQuoto.quotoCategory = "random"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getArtQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "art"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getFunnyQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "funny"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getInspirationalQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "inspirational"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getLifeQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "life"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getLoveQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "love"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getSportsQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "sports"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getManagementQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "management"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }

    @IBAction func getAngerQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "anger"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    
    @IBAction func getStrengthQuote(sender: UIButton) {
        self.newQuoto.quotoCategory = "strength"
        self.performSegueWithIdentifier("segueToQuoteDetailVC", sender: self)
    }
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! QuoteDetailViewController
        controller.newQuoto = self.newQuoto 
    }

}
