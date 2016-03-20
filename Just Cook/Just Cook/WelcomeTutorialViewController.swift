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
    
    // MARK: Properties
    let fridgeBoyImageView = UIImageView(image: UIImage(named: "FridgeBoy"))
    let welcomeLabel = UILabel()
    let letsCookButton = UIButton(type: .Custom)
    let buttonLabel = UILabel()
    let skipButton = UIButton(type: .Custom)
    let greyRectangle = UIView()
    let tutvc = TutorialPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: [:])
    
    
    // MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fridgeBoyImageView)
        fridgeBoyImageView.snp_makeConstraints { $0.edges.equalTo(self.view) }
        
        greyRectangle.backgroundColor = UIColor.blackColor()
        greyRectangle.alpha = 0.0
        view.addSubview(greyRectangle)
        greyRectangle.snp_makeConstraints { $0.edges.equalTo(self.view) }
        
        if #available(iOS 8.2, *) {
            welcomeLabel.font = UIFont.systemFontOfSize(36, weight: UIFontWeightThin)
        } else {
            welcomeLabel.font = UIFont.systemFontOfSize(36)
        }
        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = UIColor.darkTextColor()
        view.addSubview(welcomeLabel)
        welcomeLabel.snp_makeConstraints { $0.center.equalTo(self.view) }
        welcomeLabel.transform = CGAffineTransformMakeScale(0, 0)
        
        letsCookButton.setImage(UIImage(named: "lets-just-cook-button"), forState: .Normal)
        letsCookButton.addTarget(self, action: "justCookButtonPressed", forControlEvents: .TouchUpInside)
        view.addSubview(letsCookButton)
        letsCookButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.view).multipliedBy(1.6)
            make.centerX.equalTo(self.view)
        }
        
        if #available(iOS 8.2, *) {
            buttonLabel.font = UIFont.systemFontOfSize(20, weight: UIFontWeightThin)
        } else {
            buttonLabel.font = UIFont.systemFontOfSize(20)
        }
        buttonLabel.text = "Let's just cook!"
        buttonLabel.textColor = UIColor.darkTextColor()
        letsCookButton.addSubview(buttonLabel)
        buttonLabel.snp_makeConstraints { $0.center.equalTo(letsCookButton) }
        letsCookButton.transform = CGAffineTransformMakeScale(0, 0)
        
        skipButton.setImage(UIImage(named: "lets-just-cook-button"), forState: .Normal)
        skipButton.addTarget(self, action: "skipButtonPressed", forControlEvents: .TouchUpInside)
        view.addSubview(skipButton)
        skipButton.enabled = false
        skipButton.alpha = 0
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateAndChainWithDuration(1.0,
            delay: 0.3,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: [],
            animations: { self.welcomeLabel.transform = CGAffineTransformMakeScale(1, 1) },
            completion: nil)
            .animateAndChainWithDuration(0.6,
                delay: 0,
                options: [],
                animations: { self.letsCookButton.transform = CGAffineTransformMakeScale(1, 1) },
                completion: nil)
        
        
    }
    
    // MARK: Actions
    func justCookButtonPressed() {
        UIView.animateAndChainWithDuration(0.4,
            delay: 0.1,
            options: [],
            animations: {
                self.welcomeLabel.transform = CGAffineTransformMakeTranslation(20, 0)
            }, completion: nil).animateWithDuration(0.4,animations: {
                self.welcomeLabel.transform = CGAffineTransformMakeTranslation(-1000, 0)
                self.letsCookButton.transform = CGAffineTransformMakeTranslation(10, 0)
            }).animateWithDuration(0.4, animations: {
                self.letsCookButton.transform = CGAffineTransformMakeTranslation(-1000, 0)
                }, completion: willStartPresentation)
    }
    
    func skipButtonPressed() {
        /* UNCOMMENT ON RELEASE */
        //NSUserDefaults.standardUserDefaults().setBool(true, forKey: "didFinishTutorial")
        //NSUserDefaults.standardUserDefaults().synchronize()
        
        UIView.animateAndChainWithDuration(0.4, delay: 0, options: [],
            animations: {
                self.tutvc.view.transform = CGAffineTransformMakeTranslation(20, 0)
            }, completion: nil)
            .animateWithDuration(0.4, animations: {
                self.tutvc.view.transform = CGAffineTransformMakeTranslation(-1000, 0)
                self.skipButton.transform = CGAffineTransformMakeTranslation(10, 0)
            })
            .animateWithDuration(0.4, animations: {
                self.skipButton.transform = CGAffineTransformMakeTranslation(-1000, 0)
                self.greyRectangle.alpha = 0
                }, completion: disappear)
    }
    
    // MARK: Auxillary methods
    func disappear(_: Bool) {
        tutvc.view.removeFromSuperview()
        skipButton.removeFromSuperview()
        tutvc.removeFromParentViewController()
        view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    func willStartPresentation(_: Bool) {
        self.welcomeLabel.removeFromSuperview()
        self.letsCookButton.removeFromSuperview()
        self.startPresentation()
    }
    
    func changeButtonTitle() {
        self.buttonLabel.text = "Let's Cook!"
    }
    
    
    // MARK: Presentation
    func startPresentation() {
        
        self.addChildViewController(tutvc)
        view.addSubview(tutvc.view)
        tutvc.didMoveToParentViewController(self)
        tutvc.view.transform = CGAffineTransformMakeScale(0, 0)
        
        skipButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(tutvc.view.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
        
        buttonLabel.text = "Skip"
        skipButton.addSubview(buttonLabel)
        buttonLabel.snp_updateConstraints { $0.center.equalTo(skipButton) }
        
        //Will change title of skip button when last tutorial screen is shown.
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "changeButtonTitle",
            name: "lastPageIsOpened",
            object: nil)
        
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

}
