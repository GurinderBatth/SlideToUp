//
//  SlideUpView.swift
//  SlideToUp
//
//  Created by Apple on 03/03/19.
//  Copyright © 2019 Batth. All rights reserved.
//

import UIKit

class SlideUpView: UIView {

    var panGesture : UIPanGestureRecognizer!
    
    var height:CGFloat = 0
    var yAxis:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addgesture()
        height = self.bounds.height
        yAxis = self.frame.origin.y

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addgesture()
        height = self.bounds.height
        yAxis = self.frame.origin.y
    }

    func addgesture(){
        self.layer.cornerRadius = self.bounds.width / 2

        panGesture = UIPanGestureRecognizer(target: self, action: #selector(setupPanGesture(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func setupPanGesture(_ gesture: UIPanGestureRecognizer){
        print()
        let translation = gesture.translation(in: self)
        let oldRect = self.frame
        if gesture.state == .changed{
            if translation.y < 0{
                let newHeight = oldRect.size.height - 2
                let newYAxis = oldRect.origin.y - 0.7
            
                if newHeight <= oldRect.size.width{
                    self.removeGestureRecognizer(panGesture)
                    self.setupAnimation()
                    return
                }
                print(newHeight)
                self.frame = CGRect(x: oldRect.origin.x, y: newYAxis, width: oldRect.size.width, height: newHeight)
            }else{
                if oldRect.size.height < height{
                    let newHeight = oldRect.size.height + 2
                    let newYAxis = oldRect.origin.y + 0.7
                    print(newHeight)
                    self.frame = CGRect(x: oldRect.origin.x, y: newYAxis, width: oldRect.size.width, height: newHeight)
                }
            }
        }
        if gesture.state == .ended{
            if oldRect.size.height - 20 > oldRect.size.width{
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame = CGRect(x: oldRect.origin.x, y: self.yAxis, width: oldRect.size.width, height: self.height)
                }) { (completed) in
                    
                }
            }else{
                let newYAxis = oldRect.origin.y + 0.5
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame = CGRect(x: oldRect.origin.x, y: newYAxis, width: oldRect.size.width, height: oldRect.size.width)
                }) { (completed) in
                    
                }
            }
        }
    }
    
    func setupAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { (complete) in
            UIView.animate(withDuration: 0.5, animations: {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

            }, completion: { (completed) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                }, completion: { (competed) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.transform = .identity
                    }, completion: { (competed) in
                        
                    })
                })
            })
        }
    }
    
}
