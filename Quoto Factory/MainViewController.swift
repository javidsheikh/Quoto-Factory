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
        newQuoto = NewQuoto(quotoImage: image, quotoQuote: "", quotoAuthor: "")
        print(newQuoto.quotoImage)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as! QuoteViewController
        controller.newQuoto = self.newQuoto
    }
    
    // MARK: IBActions
    @IBAction func actionQuoto(sender: UIBarButtonItem) {
        let image = self.chosenImageView.image!
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, completed, items, error -> Void in
            if completed {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func restartQuoto(sender: UIBarButtonItem) {
        self.chosenImageView.image = nil
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

