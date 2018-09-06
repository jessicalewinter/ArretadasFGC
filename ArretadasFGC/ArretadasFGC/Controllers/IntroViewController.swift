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
        
        pages.append((image: img1, text: "\nJuntas somos mais fortes e fazemos a diferença."))
        pages.append((image: img2, text: "\nMas as vezes não sabemos ou esquecemos disso :("))
        pages.append((image: img3, text: "\nPor isso, criamos esse app para te ajudar :)"))
        pages.append((image: img4, text: "Faça parte de um clube e compartilhe suas experiências!"))
        
        introScrollView.frame = cgRect
        introScrollView.isDirectionalLockEnabled = true
        
        introPageControl.numberOfPages = 4
        introPageControl.pageIndicatorTintColor = UIColor.gray
        introPageControl.currentPageIndicatorTintColor = UIColor.primary
        
        
        for i in 0...3 {
            let cgFrame = CGRect(x: introScrollView.frame.size.width*CGFloat(i),
                                 y: 0.0,
                                 width: introScrollView.frame.size.width,
                                 height: introScrollView.frame.size.height)
            
            let subView = UIView(frame: cgFrame)
            subView.backgroundColor = UIColor(red: 247.0, green: 247.0, blue: 239.0, alpha: 1.0)
            
            let imgView = UIImageView(image: pages[i].image)
            imgView.contentMode = .scaleAspectFit
            
            let content = UILabel()
            content.text = pages[i].text
            content.textColor = UIColor.black
            content.textAlignment = .center
            content.numberOfLines = 0
            content.font = UIFont(name: "Avenir", size: 20)
            content.sizeToFit()
            //content.backgroundColor = UIColor(red: 247, green:247, blue:239, alfa:1.0)
            
            let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 42))
            
            subView.addSubview(imgView)
            subView.addSubview(content)
            
            introScrollView.addSubview(subView)
            
            //Constraints
            let margins = subView.layoutMarginsGuide
            
            content.translatesAutoresizingMaskIntoConstraints = false
            content.topAnchor.constraint(equalTo: margins.topAnchor, constant: 16).isActive = true
            content.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
            content.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.9).isActive = true
            //content.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 0.1).isActive = true
            
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0)
            //imgView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0)
            imgView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0)
            imgView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0).isActive = true
            imgView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
            //pode ou nao precisar a linha abaixo
            imgView.heightAnchor.constraint(equalTo: margins.heightAnchor, multiplier: 1).isActive = true
            
            if(i == 3){
                
                startButton.setTitle("Vamos lá", for: .normal)
                startButton.layer.borderWidth = 1.0
                startButton.layer.borderColor = UIColor.primary.cgColor
                startButton.setTitleColor(UIColor.primary, for: .normal)
                startButton.setCornerRadiusDefault()
                startButton.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 5.0, bottom: 15.0, right: 5.0)
                startButton.addTarget(self, action: #selector(IntroViewController.pressedStart(sender:)), for: .touchUpInside)
                self.introScrollView.addSubview(startButton)
                
                introScrollView.isPagingEnabled = true
                introScrollView.delegate = self
                
                //Start button constraints
                let margins = subView.layoutMarginsGuide
                startButton.translatesAutoresizingMaskIntoConstraints = false
                //startButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -100).isActive = true
                startButton.topAnchor.constraint(equalTo: content.bottomAnchor, constant: 8).isActive = true
                startButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
                startButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
                startButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
            }
            
            
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
