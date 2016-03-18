//
//  WelcomeTutorialViewController.swift
//  Just Cook
//
//  Created by Ilya Velilyaev on 17.03.16.
//  Copyright © 2016 Ilya Velilyaev. All rights reserved.
//

import UIKit
import SnapKit
import EasyAnimation

class WelcomeTutorialViewController: UIViewController {

    let fridgeBoyImage = UIImage(named: "FridgeBoy")
    let welcomeLabel = UILabel()
    let letsCookButton = UIButton(type: .Custom)
    let buttonLabel = UILabel()
    let skipButton = UIButton(type: .Custom)
    var greyRectangle : UIView!
    let tutvc = TutorialPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: [:])

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = fridgeBoyImage {
            
            let imageView = UIImageView(image: image)
            view.addSubview(imageView)
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.edges.equalTo(self.view)
            })
            
        }
        
        greyRectangle = UIView(frame: view.frame)
        greyRectangle.backgroundColor = UIColor.blackColor()
        greyRectangle.alpha = 0.0
        view.addSubview(greyRectangle)

        
        //MARK: welcomeLabel init
        if #available(iOS 8.2, *) {
            welcomeLabel.font = UIFont.systemFontOfSize(36, weight: UIFontWeightThin)
        } else {
            welcomeLabel.font = UIFont.systemFontOfSize(36)
        }
        
        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = UIColor.darkTextColor()
        view.addSubview(welcomeLabel)
        welcomeLabel.transform = CGAffineTransformMakeScale(0, 0)
        welcomeLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }
        
        //MARK: letsCookButton init
        letsCookButton.setImage(UIImage(named: "lets-just-cook-button"), forState: .Normal)
        letsCookButton.addTarget(self, action: "justCookButtonPressed", forControlEvents: .TouchUpInside)
        view.addSubview(letsCookButton)
        letsCookButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.view).multipliedBy(1.6)
            make.centerX.equalTo(self.view)
        }
        
        buttonLabel.text = "Let's just cook!"

        
        if #available(iOS 8.2, *) {
            buttonLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightThin)
        } else {
            buttonLabel.font = UIFont.systemFontOfSize(20)
        }
        
        buttonLabel.textColor = UIColor.darkTextColor()
        letsCookButton.addSubview(buttonLabel)
        buttonLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(letsCookButton)
        }
        letsCookButton.transform = CGAffineTransformMakeScale(0, 0)
        
        
        //MARK: skipButton
        skipButton.setImage(UIImage(named: "lets-just-cook-button"), forState: .Normal)
        skipButton.addTarget(self, action: "skipButtonPressed", forControlEvents: .TouchUpInside)
        view.addSubview(skipButton)
        skipButton.enabled = false
        skipButton.alpha = 0
    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //MARK: WelcomeLabel and button appear
        
        UIView.animateAndChainWithDuration(1.0,
            delay: 0.3,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: [],
            animations: { () -> Void in
                self.welcomeLabel.transform = CGAffineTransformMakeScale(1, 1)
            },
            completion: nil).animateAndChainWithDuration(0.6,
                delay: 0,
                options: [],
                animations: { () -> Void in
                    self.letsCookButton.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: nil)

    }
    
    func justCookButtonPressed() {
        UIView.animateAndChainWithDuration(0.4,
            delay: 0.1,
            options: [],
            animations: { () -> Void in
                self.welcomeLabel.transform = CGAffineTransformMakeTranslation(20, 0)
            }, completion: nil).animateAndChainWithDuration(0.4,
                delay: 0,
                options: [],
                animations: { () -> Void in
                    self.welcomeLabel.transform = CGAffineTransformMakeTranslation(-1000, 0)
                    self.letsCookButton.transform = CGAffineTransformMakeTranslation(10, 0)
                }, completion: nil).animateWithDuration(0.4,
                    animations: { () -> Void in
                        self.letsCookButton.transform = CGAffineTransformMakeTranslation(-1000, 0)
                    }) { (completed: Bool) -> Void in
                        if completed {
                            self.welcomeLabel.removeFromSuperview()
                            self.letsCookButton.removeFromSuperview()
                            self.startPresentation()
                        }
        } //completion
        
        
    }
    
    func startPresentation() {
        self.addChildViewController(tutvc)
        
        self.view.addSubview(tutvc.view)
        tutvc.didMoveToParentViewController(self)
        
        
        
        tutvc.view.transform = CGAffineTransformMakeScale(0, 0)
        
        tutvc.view.setNeedsUpdateConstraints()
        
        skipButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tutvc.view.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        buttonLabel.text = "Skip"
        skipButton.addSubview(buttonLabel)
        buttonLabel.snp_updateConstraints { (make) -> Void in
            make.center.equalTo(skipButton)
        }
        view.setNeedsUpdateConstraints()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "changeButtonTitle", name: "lastPageIsOpened", object: nil)
        
        
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            options: [],
            animations: { () -> Void in
                self.tutvc.view.transform = CGAffineTransformMakeScale(1, 1)
                self.greyRectangle.alpha = 0.7
                self.skipButton.enabled = true
                self.skipButton.alpha = 1
            },
            completion: nil)
        
        
    }
    
    func changeButtonTitle() {
        self.buttonLabel.text = "Let's Cook!"
    }
    
    func skipButtonPressed() {
        print("skip")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }
    
}
