//
//  ViewController.swift
//  AirPlayPOC
//
//  Created by Ventuno Technologies on 15/06/20.
//  Copyright © 2020 Ventuno Technologies. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet weak var mPlayerHld: UIView!
    
    @IBOutlet weak var mAirplayType1Hld: UIView!
    @IBOutlet weak var mAirplayType2Hld: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupPlayer()
    }
    
}
extension ViewController{
    
    private func setupPlayer(){
        
//        let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        
        let videoURL = URL(string: "http://livesim.dashif.org/livesim/testpic_2s/Manifest.mpd")
        
        let asset = AVURLAsset(url: videoURL!)
        let playerItem = AVPlayerItem(asset: asset)
        
        let player = AVPlayer(playerItem: playerItem)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        playerViewController.view.frame = mPlayerHld.frame
        
        self.addChild(playerViewController)
        self.view.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
        
        //player.play()
        
        setupAirplay()
        setupAirplayType2()
    }
}
extension ViewController{
    
    private func setupAirplay(){
        let buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        let airplayButton = MPVolumeView(frame: buttonFrame)
        airplayButton.showsVolumeSlider = false
        mAirplayType1Hld.addSubview(airplayButton)
       
    }
    
    private func setupAirplayType2(){
        
        let buttonFrame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        // It's highly recommended to use the AVRoutePickerView in order to avoid AirPlay issues after iOS 11.
        if #available(iOS 11.0, *) {
            let airplayButton = AVRoutePickerView(frame: buttonFrame)
            airplayButton.activeTintColor = UIColor.blue
            airplayButton.tintColor = UIColor.white
            if #available(iOS 13.0, *) {
                airplayButton.prioritizesVideoDevices = true
            }
            mAirplayType2Hld.addSubview(airplayButton)
        } else {
            // If you still support previous iOS versions you can use MPVolumeView
            let airplayButton = MPVolumeView(frame: buttonFrame)
            airplayButton.showsVolumeSlider = false
            mAirplayType2Hld.addSubview(airplayButton)
        }
    }
    
    
}

