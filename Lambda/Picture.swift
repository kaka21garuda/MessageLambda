//
//  Picture.swift
//  Lambda
//
//  Created by Buka Cakrawala on 10/11/16.
//  Copyright © 2016 Buka Cakrawala. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class Picture: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var nameField: UITextField!
    
    
    @IBAction func takePhoto(_ sender: AnyObject) {
    
    }
    
    @IBAction func submit(_ sender: AnyObject) {
        
    }
    
    var captureSession = AVCaptureSession()
    var stillImageOutput = AVCaptureStillImageOutput()
    //Preview Layer variable so that the user can see the photo they capture
    var previewLayer = AVCaptureVideoPreviewLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let devices = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        for device in devices! {
            //Grab the front camera of the device
            if (device as! AVCaptureDevice).position == AVCaptureDevicePosition.front {
                do {
                    let input = try AVCaptureDeviceInput(device: device as! AVCaptureDevice)
                    if captureSession.canAddInput(input) {
                        captureSession.addInput(input)
                        //to grab the video coming from it and grab the JPEG coming from it.
                        stillImageOutput.outputSettings = [AVVideoCodecKey: AVVideoCodecJPEG]
                        
                        //Add the output after capturing
                        if captureSession.canAddOutput(stillImageOutput) {
                            captureSession.addOutput(stillImageOutput)
                            captureSession.startRunning()
                            
                            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                            //Add some video gravity
                            previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                            //Setup the orientation
                            previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.portrait
                            //Now add on camera view
                            cameraView.layer.addSublayer(previewLayer)
                            
                            
                            previewLayer.bounds = cameraView.frame
                            previewLayer.position = CGPoint(x: cameraView.frame.width / 2, y: cameraView.frame.height / 2)
                            
                        }
                    }
                    
                } catch {
                    print(error)
                }
                
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    
    

    
}
