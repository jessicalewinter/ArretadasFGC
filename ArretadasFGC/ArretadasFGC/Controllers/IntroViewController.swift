//
//  IntroViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    let transition = Transition(duration: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func start(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Feed", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)

    }
}

extension IntroViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
}
