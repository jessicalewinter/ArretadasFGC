//
//  Transition.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class Transition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: Double?
    var presenting = true
    
    init(duration: Double) {
        self.duration = duration
        super.init()
        
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration!
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        container.addSubview(toView)
        
        toView.transform = CGAffineTransform(translationX: container.frame.origin.x * 2 , y: container.frame.origin.y)
        toView.alpha = 0.0
        UIView.animate(withDuration: duration!, animations: {
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        }
        )
    }
    

}
