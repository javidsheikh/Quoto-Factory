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
    
    // MARK: IBOutlets
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var imageSubView: UIView!
    @IBOutlet weak var chosenImageView: UIImageView!
    @IBOutlet weak var chosenQuoteLabel: UILabel!
    @IBOutlet weak var chosenAuthorLabel: UILabel!
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIToolbar!
    
    @IBOutlet weak var chooseQuoteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gestureQuote = UIPanGestureRecognizer(target: self, action: Selector("dragQuoteLabel:"))
        let gestureAuthor = UIPanGestureRecognizer(target: self, action: Selector("dragAuthorLabel:"))
        chosenQuoteLabel.addGestureRecognizer(gestureQuote)
        chosenQuoteLabel.userInteractionEnabled = true
        chosenAuthorLabel.addGestureRecognizer(gestureAuthor)
        chosenAuthorLabel.userInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: Selector("resizeText:"))
        self.view.addGestureRecognizer(pinchGesture)
    }
    
    override func viewWillAppear(animated: Bool) {

        if self.newQuoto == nil {
            self.chosenQuoteLabel.hidden = true
            self.chosenAuthorLabel.hidden = true
        } else {
            self.chosenImageView.image = self.newQuoto.quotoImage
            
            self.chosenQuoteLabel.hidden = false
            self.chosenQuoteLabel.text = self.newQuoto.quotoQuote
            
            self.chosenAuthorLabel.hidden = false
            self.chosenAuthorLabel.text = self.newQuoto.quotoAuthor
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
            newQuoto = NewQuoto(quotoImage: image, quotoQuote: "", quotoAuthor: "")
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
            self.newQuoto = NewQuoto(quotoImage: self.chosenImageView.image!, quotoQuote: "", quotoAuthor: "")
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
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: 150 + translation.y)
    }
    
    func dragAuthorLabel(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.view)
        let label = chosenAuthorLabel
        label.center = CGPoint(x: 350 + translation.x, y: 300 + translation.y)
    }
    
    func resizeText(pinchGesture: UIPinchGestureRecognizer) {
        let scale = pinchGesture.scale
        chosenQuoteLabel.font = chosenQuoteLabel.font.fontWithSize(17 * scale)
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
        self.chosenImageView.image = UIImage(named: "Cat_Placeholder.jpg")
        self.chosenQuoteLabel.text = ""
        self.chosenAuthorLabel.text = ""
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
