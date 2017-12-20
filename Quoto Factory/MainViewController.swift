//
//  MainViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: variables
    var newQuoto: NewQuoto!
    
    var chosenQuoteLabel: UILabel!
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var leadingConstraint: NSLayoutConstraint!
    var constraints: [NSLayoutConstraint]!
    var quoteLabelPosition: CGPoint!
    var quoteLabelFontSize: CGFloat!
    
    var isWhite = true

    var topConstraintConstant: CGFloat!
    var bottomConstraintConstant: CGFloat!
    var trailingConstraintConstant: CGFloat!
    var leadingConstraintConstant: CGFloat!
    
    // Rate me variables
    var minSessions = 5
    var tryAgainSessions = 3
    
    // MARK: IBOutlets
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var instructionLabelMiddle: UILabel!
    
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var labelSubview: UIView!
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIToolbar!
    
    @IBOutlet weak var chooseQuoteButton: UIButton!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI setup
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 242/255, green: 46/255, blue: 70/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont(name: "Futura-CondensedExtraBold", size: 24)!]
        
        self.toolbar.barTintColor = UIColor(red: 242/255, green: 46/255, blue: 70/255, alpha: 1.0)
        self.toolbar.tintColor = UIColor.white
        
        self.instructionLabelMiddle.layer.masksToBounds = true
        self.instructionLabelMiddle.layer.cornerRadius = 12
        
        // Chosen quote label
        self.chosenQuoteLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.labelSubview.bounds.width - 100, height: self.labelSubview.bounds.height - 100))
        self.chosenQuoteLabel.textAlignment = .center
        self.chosenQuoteLabel.numberOfLines = 0
        self.chosenQuoteLabel.translatesAutoresizingMaskIntoConstraints = false
        self.labelSubview.addSubview(chosenQuoteLabel)
        // Constraints
        self.topConstraintConstant = 0
        self.bottomConstraintConstant = 0
        self.trailingConstraintConstant = 0
        self.leadingConstraintConstant = 0
        self.topConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .top, relatedBy: .equal, toItem: self.labelSubview, attribute: .topMargin, multiplier: 1, constant: topConstraintConstant)
        self.bottomConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .bottom    , relatedBy: .equal, toItem: self.labelSubview, attribute: .bottomMargin, multiplier: 1, constant: bottomConstraintConstant)
        self.trailingConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .trailing, relatedBy: .equal, toItem: self.labelSubview, attribute: .trailingMargin, multiplier: 1, constant: trailingConstraintConstant)
        self.leadingConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .leading, relatedBy: .equal, toItem: self.labelSubview, attribute: .leadingMargin, multiplier: 1, constant: leadingConstraintConstant)
        self.constraints = [topConstraint, bottomConstraint, trailingConstraint, leadingConstraint]
        self.labelSubview.addConstraints(constraints)
        
        // Text attributes
        self.chosenQuoteLabel.font = UIFont(name: "GillSans-Bold", size: 22)
        self.chosenQuoteLabel.textColor = UIColor.white
        self.chosenQuoteLabel.layer.shadowColor = UIColor.black.cgColor
        self.chosenQuoteLabel.layer.shadowRadius = 1
        self.chosenQuoteLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.chosenQuoteLabel.layer.shadowOpacity = 1
        
        // Gesture recognizers
        let gestureQuote = UIPanGestureRecognizer(target: self, action: #selector(MainViewController.dragQuoteLabel(_:)))
        self.chosenQuoteLabel.addGestureRecognizer(gestureQuote)
        self.chosenQuoteLabel.isUserInteractionEnabled = true
        
        self.quoteLabelPosition = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(MainViewController.resizeText(_:)))
        self.view.addGestureRecognizer(pinchGesture)
        
        self.quoteLabelFontSize = 22
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(MainViewController.changeQuoteFontColor(_:)))
        longPress.minimumPressDuration = 1.2
        self.view.addGestureRecognizer(longPress)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Set image and quote if chosen
        if self.newQuoto == nil {
            self.chosenQuoteLabel.isHidden = true
            self.instructionLabelMiddle.alpha = 0
        } else {
            self.chosenImageView.image = self.newQuoto.quotoImage
            
            self.chosenQuoteLabel.isHidden = false
            self.chosenQuoteLabel.text = self.newQuoto.quotoQuote + self.newQuoto.quotoAuthor
            
            self.instructionLabelMiddle.alpha = 1
        }
        
        // Disable camera button if camera not available
        self.cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // Disable share button if no image is selected
        if self.chosenImageView.image == UIImage(named: "Placeholder.png") {
            self.actionButton.isEnabled = false
        } else {
            self.actionButton.isEnabled = true
        }
        
        if self.chosenQuoteLabel.text == nil && self.chosenImageView.image
            == UIImage(named: "Placeholder.png") {
            self.cancelButton.isEnabled = false
        } else {
            self.cancelButton.isEnabled = true
        }
                
        // Hide instruction labels
        UIView.animate(withDuration: 2, delay: 6, options: .curveLinear, animations: { () -> Void in
            self.instructionLabelMiddle.alpha = 0
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Image picker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        guard let image = image as? UIImage else {
            print("Unable to select chosen image")
            return
        }
        self.chosenImageView.image = image
        if self.newQuoto == nil {
            newQuoto = NewQuoto(quotoImage: image, quotoQuote: "", quotoAuthor: "", quotoCategory: "")
        } else {
            self.newQuoto.quotoImage = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! QuoteViewController
        if self.newQuoto == nil {
            self.newQuoto = NewQuoto(quotoImage: UIImage(named: "Placeholder.png")!, quotoQuote: "", quotoAuthor: "", quotoCategory: "")
        }
        controller.newQuoto = self.newQuoto
    }
    
    // MARK: generate quoto function
    fileprivate func generateQuoto() -> UIImage {
        self.navigationController?.isNavigationBarHidden = true
        self.toolbar.isHidden = true
        self.instructionLabelMiddle.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let quoto: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                
        self.navigationController?.isNavigationBarHidden = false
        self.toolbar.isHidden = false
        self.instructionLabelMiddle.isHidden = false
        
        return quoto
    }
    
    // MARK: gesture recognizer functions
    func dragQuoteLabel(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.view)
        let label = self.chosenQuoteLabel
        label?.center = CGPoint(x: self.quoteLabelPosition.x + translation.x, y: self.quoteLabelPosition.y + translation.y)
        
        if gesture.state == .ended {
            self.quoteLabelPosition = CGPoint(x: self.quoteLabelPosition.x + translation.x, y: self.quoteLabelPosition.y + translation.y)

            self.labelSubview.removeConstraints(self.constraints)
            self.topConstraintConstant = self.topConstraintConstant + translation.y
            self.bottomConstraintConstant = self.bottomConstraintConstant + translation.y
            self.trailingConstraintConstant =  self.trailingConstraintConstant + translation.x
            self.leadingConstraintConstant = self.leadingConstraintConstant + translation.x
            self.topConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .top, relatedBy: .equal, toItem: self.labelSubview, attribute: .top, multiplier: 1, constant: topConstraintConstant)
            self.bottomConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .bottom    , relatedBy: .equal, toItem: self.labelSubview, attribute: .bottom, multiplier: 1, constant: bottomConstraintConstant)
            self.trailingConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .trailing, relatedBy: .equal, toItem: self.labelSubview, attribute: .trailing, multiplier: 1, constant: trailingConstraintConstant)
            self.leadingConstraint = NSLayoutConstraint(item: chosenQuoteLabel, attribute: .leading, relatedBy: .equal, toItem: self.labelSubview, attribute: .leading, multiplier: 1, constant: leadingConstraintConstant)
            self.constraints = [topConstraint, bottomConstraint, trailingConstraint, leadingConstraint]
            self.labelSubview.addConstraints(constraints)
        }
    }
    
    func resizeText(_ pinchGesture: UIPinchGestureRecognizer) {
        let scale = pinchGesture.scale
        self.chosenQuoteLabel.font = chosenQuoteLabel.font.withSize(quoteLabelFontSize * scale)
        
        if pinchGesture.state == .ended {
            quoteLabelFontSize = quoteLabelFontSize * scale
        }
    }
    
    func changeQuoteFontColor(_ longPress: UILongPressGestureRecognizer) {
        if longPress.state == .began {
            if self.isWhite {
                self.chosenQuoteLabel.textColor = UIColor.black
                self.isWhite = false
            } else {
                self.chosenQuoteLabel.textColor = UIColor.white
                self.isWhite = true
            }
        }
    }

    // MARK: rate app functions - to be uncommented once app ID is received.
    func rateMe() {
        let neverRate = UserDefaults.standard.bool(forKey: "neverRate")
        var numLaunches = UserDefaults.standard.integer(forKey: "numLaunches") + 1
        if (!neverRate && (numLaunches == minSessions || numLaunches >= (minSessions + tryAgainSessions + 1))) {
            showRateMe()
            numLaunches = minSessions + 1
        }
        UserDefaults.standard.set(numLaunches, forKey: "numLaunches")
    }
    
    func showRateMe() {
        let alert = UIAlertController(title: "Rate Us", message: "Thanks for using Quoto Factory", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Rate Quoto Factory", style: UIAlertActionStyle.default, handler: { alertAction in
            UIApplication.shared.openURL(URL(string : "itms-apps://itunes.apple.com/app/id1100309467")!)
            UserDefaults.standard.set(true, forKey: "neverRate")
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Never", style: UIAlertActionStyle.default, handler: { alertAction in
            UserDefaults.standard.set(true, forKey: "neverRate")
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.default, handler: { alertAction in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: IBActions
    @IBAction func actionQuoto(_ sender: UIBarButtonItem) {
        let image = self.generateQuoto()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, completed, items, error -> Void in
            if completed {
                self.rateMe()
            }
        
        }
        // if iPhone
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone) {
            // go on..
        } else {
            // for iPad
            if controller.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
                controller.popoverPresentationController!.barButtonItem = self.actionButton;
            }
        }
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func restartQuoto(_ sender: UIBarButtonItem) {
        self.chosenImageView.image = UIImage(named: "Placeholder.png")
        self.chosenQuoteLabel.text = ""
        self.newQuoto = nil
    }
    
    @IBAction func pickImageFromCamera(_ sender: UIBarButtonItem) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .camera
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func pickFromAlbum(_ sender: UIBarButtonItem) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func chooseQuote(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToQuoteVC", sender: self)
    }
}

