//
//  IntroViewController.swift
//  ArretadasFGC
//
//  Created by Ada 2018 on 05/09/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var introScrollView: UIScrollView!
    @IBOutlet weak var introPageControl: UIPageControl!
    
    let backgroundColor : UIColor = UIColor(red: 247, green: 247, blue: 239, alpha: 1.0)
    
    let transition = Transition(duration: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let widthMainView: CGFloat = self.view.bounds.width
        let heightMainView: CGFloat = self.view.bounds.height
        
        let cgRect = CGRect(x: 0.0, y: 0.0, width: widthMainView, height: heightMainView)
        
        var pages : [(image: UIImage, text: String)] = []
        
        let img1 = #imageLiteral(resourceName: "thalia")
        let img2 = #imageLiteral(resourceName: "debora")
        let img3 = #imageLiteral(resourceName: "jessica")
        let img4 = #imageLiteral(resourceName: "paloma")
        
        pages.append((image: img1, text: "Sometimes it becomes difficult to have a good brainstorm with different and restless minds, often out of focus ..."))
        pages.append((image: img2, text: "Sometimes it becomes difficult to have a good brainstorm with different and restless minds, often out of focus ..."))
        pages.append((image: img3, text: "Sometimes it becomes difficult to have a good brainstorm with different and restless minds, often out of focus ..."))
        pages.append((image: img4, text: ""))
        
        introScrollView.frame = cgRect
        introScrollView.isDirectionalLockEnabled = true
        
        introPageControl.numberOfPages = 4
        introPageControl.pageIndicatorTintColor = UIColor.primary
        introPageControl.currentPageIndicatorTintColor = UIColor(white: 90, alpha: 1.0)
        
        for i in 0...3 {
            let cgFrame = CGRect(x: introScrollView.frame.size.width*CGFloat(i),
                                 y: 0.0,
                                 width: introScrollView.frame.size.width,
                                 height: introScrollView.frame.size.height)
            
            let subView = UIView(frame: cgFrame)
            
            let imgView = UIImageView(image: pages[i].image)
            imgView.contentMode = .scaleAspectFit
            let content = UILabel()
            content.textColor = UIColor(white: 45, alpha: 1.0)
            let backgroundLabel = UIView(frame: cgFrame)
            backgroundLabel.backgroundColor = UIColor(red: 255/255, green: 168/255, blue: 105/255, alpha: 1)
            
            
            let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 42))
            
            content.text = pages[i].text
            content.textAlignment = .center
            content.numberOfLines = 0
            content.font = UIFont(name: "Auvenir", size: 17)
            content.textColor = UIColor(white: 45, alpha: 1.0)
//            content.sizeToFit()
            subView.backgroundColor = backgroundColor
            
            
            subView.addSubview(imgView)
            backgroundLabel.addSubview(content)
            
            subView.addSubview(backgroundLabel)
            
            introScrollView.addSubview(subView)
            
            if(i == 3){
                backgroundLabel.backgroundColor = UIColor.clear
                
                startButton.setTitle("Vamos lá", for: .normal)
                startButton.backgroundColor = UIColor.primary
                startButton.addTarget(self, action: #selector(IntroViewController.pressedStart(sender:)), for: .touchUpInside)
                self.introScrollView.addSubview(startButton)
                
                introScrollView.isPagingEnabled = true
                introScrollView.delegate = self
                
                //Start button constraints
                let margins = subView.layoutMarginsGuide
                startButton.translatesAutoresizingMaskIntoConstraints = false
                startButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -180).isActive = true
                startButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
                startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
                startButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
            }
            
            //Constraints
            
            let margins = subView.layoutMarginsGuide
            
            
            backgroundLabel.translatesAutoresizingMaskIntoConstraints = false
            backgroundLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -100).isActive = true
            backgroundLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
            backgroundLabel.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
            backgroundLabel.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.3).isActive = true
            
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 200)
            imgView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 200)
            imgView.bottomAnchor.constraint(equalTo: backgroundLabel.topAnchor, constant: 110).isActive = true
            imgView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
            
            content.translatesAutoresizingMaskIntoConstraints = false
            content.centerXAnchor.constraint(equalTo: backgroundLabel.centerXAnchor).isActive = true
            content.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor).isActive = true
            content.widthAnchor.constraint(equalTo: backgroundLabel.widthAnchor, multiplier: 0.8).isActive = true
            content.heightAnchor.constraint(equalTo: backgroundLabel.heightAnchor, multiplier: 1).isActive = true
            
            print(backgroundLabel.frame.size.height)
            
            backgroundLabel.layer.cornerRadius = backgroundLabel.frame.size.height/8
        }
        
        introScrollView.contentSize = CGSize(width: introScrollView.frame.size.width*CGFloat(4),
                                             height: introScrollView.frame.size.height)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func pressedStart(sender: UIButton!){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let tc = sb.instantiateViewController(withIdentifier: "mainTabController") as! UITabBarController
        tc.transitioningDelegate = self
        self.present(tc, animated: true, completion: nil)
    }

    @IBAction func changePage(_ sender: Any) {
        let frame = CGRect(x: introScrollView.frame.size.width * CGFloat(introPageControl.currentPage),
                           y: 0.0,
                           width: introScrollView.frame.size.width,
                           height: introScrollView.frame.size.width)
        
        introScrollView.scrollRectToVisible(frame, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1
        introPageControl.currentPage = Int(page)
        
        //impedir que o usuário saia da tela
        scrollView.contentOffset.y = 0
        let frame = CGRect(x: introScrollView.frame.size.width * CGFloat(introPageControl.currentPage),
                           y: 0.0,
                           width: introScrollView.frame.size.width,
                           height: introScrollView.frame.size.width)
        
        if(page == 0 && scrollView.contentOffset.x < 0){
            introScrollView.scrollRectToVisible(frame, animated: false)
        } else if(page == 3 && scrollView.contentOffset.x + view.frame.width > scrollView.frame.size.width * 4){
            introScrollView.scrollRectToVisible(frame, animated: false)
        }
        
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
