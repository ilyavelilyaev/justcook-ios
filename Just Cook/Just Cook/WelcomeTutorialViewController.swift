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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = fridgeBoyImage {
            
            let imageView = UIImageView(image: image)
            view.addSubview(imageView)
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.edges.equalTo(self.view)
            })
            
        }

    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        //MARK: welcomeLabel init
        let welcomeLabel = UILabel()
        if #available(iOS 8.2, *) {
            welcomeLabel.font = UIFont.systemFontOfSize(36, weight: UIFontWeightThin)
        } else {
            welcomeLabel.font = UIFont.systemFontOfSize(36)
        }

        welcomeLabel.text = "Welcome!"
        welcomeLabel.textColor = UIColor.darkTextColor()
        view.addSubview(welcomeLabel)
        
        welcomeLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
        }

        welcomeLabel.transform = CGAffineTransformMakeScale(0, 0)
        
        
        //MARK: letsCookButton init
        let letsCookButton = UIButton(type: .Custom)
        letsCookButton.setImage(UIImage(named: "lets-just-cook-button"), forState: .Normal)
        view.addSubview(letsCookButton)
        
        letsCookButton.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.view).multipliedBy(1.6)
            make.centerX.equalTo(self.view)
        }
        
        let buttonLabel = UILabel()
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

        
        //MARK: WelcomeLabel and button appear
        
        UIView.animateAndChainWithDuration(1.0,
            delay: 0.3,
            usingSpringWithDamping: 0.33,
            initialSpringVelocity: 0,
            options: [],
            animations: { () -> Void in
                welcomeLabel.transform = CGAffineTransformMakeScale(1, 1)
            },
            completion: nil).animateAndChainWithDuration(0.4,
                delay: 0,
                options: [],
                animations: { () -> Void in
                    letsCookButton.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: nil)

        
    }
    
}
