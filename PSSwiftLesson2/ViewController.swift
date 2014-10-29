//
//  ViewController.swift
//  PSSwiftLesson2
//
//  Created by M on 29.10.14.
//  Copyright (c) 2014 M. All rights reserved.
//

// Домашнее задание
// 1. Сделать слайд шоу по нескольким картинкам, с кнопками вперед и назад

import UIKit

class ViewController: UIViewController {
    
    var scrollView:UIScrollView?
    var numberPageImage:UIImageView?
    
    var timer:NSTimer? = nil
    
    let frameOffsets:[Int] = [45, 110, 130, 110, 95, 100, 100, 85, 90, 95, 105, 105, 100]
    let frameWidth = 100 // in points
    let frameHeight = 300 // in points
    var currentSlide = 0
    
    // MARK: ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.grayColor()
        
        // scrollView
        
        let imageStrip:UIImage? = UIImage(named: "strip")
    
        let startYPos = CGFloat((self.view.bounds.size.height - imageStrip!.size.height) / 2.0)
        
        scrollView = UIScrollView(frame: CGRectMake(160, startYPos, CGFloat(frameWidth), CGFloat(frameHeight)))
        self.view.addSubview(scrollView!)
        
        let imageViewStrip = UIImageView(image: imageStrip)
        scrollView!.addSubview(imageViewStrip)
        
        // Image with "Digit"
        
        numberPageImage = UIImageView(frame: CGRect(x: 200, y: startYPos + CGFloat(frameHeight) + 20, width: 20, height: 20))
        self.view.addSubview(numberPageImage!)
        
        // button Start
        
        let buttonYOffset:CGFloat = 50;
        
        var buttonStart:UIButton = UIButton(frame: CGRect(x: 40, y: startYPos + buttonYOffset, width: 100, height: 50))
        buttonStart.setTitle("Авто старт", forState: UIControlState.Normal)
        buttonStart.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        buttonStart.addTarget(self, action: "startTimer", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonStart)
        
        // button Stop
        
        var buttonStop:UIButton = UIButton(frame: CGRect(x: 40, y: startYPos + buttonYOffset * 2, width: 100, height: 50))
        buttonStop.setTitle("Авто стоп", forState: UIControlState.Normal)
        buttonStop.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        buttonStop.addTarget(self, action: "stopTimer", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonStop)
        
        // button Left
        
        var buttonLeft:UIButton = UIButton(frame: CGRect(x: 40, y: startYPos + buttonYOffset * 3, width: 100, height: 50))
        buttonLeft.setTitle("Влево", forState: UIControlState.Normal)
        buttonLeft.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        buttonLeft.addTarget(self, action: "leftButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonLeft)
        
        // button Right
        
        var buttonRight:UIButton = UIButton(frame: CGRect(x: 40, y: startYPos + buttonYOffset * 4, width: 100, height: 50))
        buttonRight.setTitle("Вправо", forState: UIControlState.Normal)
        buttonRight.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        buttonRight.addTarget(self, action: "rightButtonTapped", forControlEvents: .TouchUpInside)
        self.view.addSubview(buttonRight)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        sleep(1)
        currentSlide = -1
        nextSlide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Slider Controls
    
    func showPageNumber() {
        numberPageImage?.image = UIImage(named: "digit-\(currentSlide + 1)")
    }
    
    func showCurrentSlide() {
        var offset = 0
        for i in 0...currentSlide {
            offset += frameOffsets[i]
        }
        scrollView!.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        showPageNumber()
    }
    
    func prevSlide() {
        if (currentSlide > 0) {
            currentSlide--
            showCurrentSlide()
        } else {
            stopTimer()
        }
    }
    
    func nextSlide() {
        if (currentSlide < frameOffsets.count - 1) {
            currentSlide++
            showCurrentSlide()
        } else {
            stopTimer()
        }
    }
    
    // MARK: Timer Controls
    
    func startTimer() {
        if timer == nil {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:Selector("nextSlide"), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        if let t = timer {
            t.invalidate()
            timer = nil
        }
    }
    
    // MARK: IBActions Methods
    
    func leftButtonTapped() {
        stopTimer()
        prevSlide()
    }
    
    func rightButtonTapped() {
        stopTimer()
        nextSlide()
    }
}
