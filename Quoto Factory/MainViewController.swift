//
//  MainViewController.swift
//  Quoto Factory
//
//  Created by Javid Sheikh on 23/02/2016.
//  Copyright © 2016 Javid Sheikh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var newQuoto: NewQuoto!
    
    var quoteLabelPosition: CGPoint!
    var quoteLabelFontSize: CGFloat!
    
    // MARK: IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var instructionLabelTop: UILabel!
    @IBOutlet weak var instructionLabelMiddle: UILabel!
    @IBOutlet weak var instructionLabelBottom: UILabel!
    
    @IBOutlet var instructionLabels: [UILabel]!
    
    @IBOutlet weak var imageSubView: UIView!
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var chosenQuoteLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIToolbar!
    
    @IBOutlet weak var chooseQuoteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for label in self.instructionLabels {
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 12
        }
        
        let gestureQuote = UIPanGestureRecognizer(target: self, action: Selector("dragQuoteLabel:"))
        chosenQuoteLabel.addGestureRecognizer(gestureQuote)
        chosenQuoteLabel.userInteractionEnabled = true
        
        quoteLabelPosition = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: Selector("resizeText:"))
        self.view.addGestureRecognizer(pinchGesture)
        
        quoteLabelFontSize = 17
    }
    
    override func viewWillAppear(animated: Bool) {

        if self.newQuoto == nil {
            self.chosenQuoteLabel.hidden = true
            self.instructionLabelTop.hidden = true
            self.instructionLabelMiddle.hidden = true
        } else {
            self.chosenImageView.image = self.newQuoto.quotoImage
            
            self.chosenQuoteLabel.hidden = false
            self.chosenQuoteLabel.text = "\(self.newQuoto.quotoQuote) - \(self.newQuoto.quotoAuthor)"
            
            self.instructionLabelBottom.hidden = true
        }
        
        // Disable camera button if camera not available
        self.cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Disable share button if no image is selected
        if self.chosenImageView.image == nil {
            self.actionButton.enabled = false
            self.cancelButton.enabled = false
        } else {
            self.actionButton.enabled = true
            self.cancelButton.enabled = true
        }
        
        // Hide instruction labels
        UIView.animateWithDuration(2, delay: 6, options: .CurveLinear, animations: { () -> Void in
            self.instructionLabelTop.alpha = 0
            self.instructionLabelMiddle.alpha = 0
            self.instructionLabelBottom.alpha = 0
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Image picker delegate methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        guard let image = image as? UIImage else {
            print("Unable to select chosen image")
            return
        }
        self.chosenImageView.image = image
        self.view.sendSubviewToBack(imageSubView)
        if self.newQuoto == nil {
            newQuoto = NewQuoto(quotoImage: image, quotoQuote: "", quotoAuthor: "", quotoCategory: "")
        } else {
            self.newQuoto.quotoImage = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! QuoteViewController
        if self.newQuoto == nil {
            self.newQuoto = NewQuoto(quotoImage: UIImage(named: "Cat_Placeholder.jpg")!, quotoQuote: "", quotoAuthor: "", quotoCategory: "")
        }
        controller.newQuoto = self.newQuoto
    }
    
    // MARK: generate quoto function
    func generateQuoto() -> UIImage {
        self.navigationBar.hidden = true
        self.toolbar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let quoto: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        self.navigationBar.hidden = false
        self.toolbar.hidden = false
        
        return quoto
    }
    
    // MARK: gesture recognizer functions
    func dragQuoteLabel(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.view)
        let label = chosenQuoteLabel
        label.center = CGPointMake(self.quoteLabelPosition.x + translation.x, self.quoteLabelPosition.y + translation.y)
        
        if gesture.state == .Ended {
            quoteLabelPosition = CGPointMake(self.quoteLabelPosition.x + translation.x, self.quoteLabelPosition.y + translation.y)
            print(quoteLabelPosition)
        }
    }
    
    func resizeText(pinchGesture: UIPinchGestureRecognizer) {
        let scale = pinchGesture.scale
        chosenQuoteLabel.font = chosenQuoteLabel.font.fontWithSize(quoteLabelFontSize * scale)
        
        if pinchGesture.state == .Ended {
            quoteLabelFontSize = quoteLabelFontSize * scale
            print(quoteLabelFontSize)
        }
    }
    
    // MARK: IBActions
    @IBAction func actionQuoto(sender: UIBarButtonItem) {
        let image = self.generateQuoto()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        controller.completionWithItemsHandler = { activity, completed, items, error -> Void in
//            if completed {
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
//        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func restartQuoto(sender: UIBarButtonItem) {
        self.chosenImageView.image = nil
        self.chosenQuoteLabel.text = ""
        self.newQuoto = nil
    }
    
    @IBAction func pickImageFromCamera(sender: UIBarButtonItem) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .Camera
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func pickFromAlbum(sender: UIBarButtonItem) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .PhotoLibrary
        self.presentViewController(controller, animated: true, completion: nil)
    }

    @IBAction func chooseQuote(sender: UIButton) {
        self.performSegueWithIdentifier("segueToQuoteVC", sender: self)
    }
}

