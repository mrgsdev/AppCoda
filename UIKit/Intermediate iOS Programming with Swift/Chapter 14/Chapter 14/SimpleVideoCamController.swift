//
//  SimpleVideoCamController.swift
//  Chapter 14
//
//  Created by mrgsdev on 01.05.2024.
//

import UIKit
import AVFoundation
import AVKit

class SimpleVideoCamController: UIViewController {
    
    @IBOutlet var cameraButton:UIButton!
    
    var currentDevice: AVCaptureDevice!
    var videoFileOutput: AVCaptureMovieFileOutput!
    let captureSession = AVCaptureSession()
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configure() {
        // Preset the session for taking photo in full resolution
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        
        // Get the back-facing camera for capturing videos
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        currentDevice = device
        // Get the input data source
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: currentDevice) else {
            return
        }
        // Configure the session with the output for capturing video
        videoFileOutput = AVCaptureMovieFileOutput()
        // Configure the session with the input and the output devices
        captureSession.addInput(captureDeviceInput)
        captureSession.addOutput(videoFileOutput)
        // Provide a camera preview
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(cameraPreviewLayer!)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.frame = view.layer.frame
        // Bring the camera button to front
        view.bringSubviewToFront(cameraButton)
        captureSession.startRunning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playVideo" {
            let videoPlayerViewController = segue.destination as! AVPlayerViewController
            let videoFileURL = sender as! URL
            videoPlayerViewController.player = AVPlayer(url: videoFileURL)
        }
        
    }
    // MARK: - Action methods
    
    @IBAction func unwindToCamera(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func capture(sender: AnyObject) {
        if !isRecording {
            isRecording = true
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse, .allowUserInteraction], animations: { () -> Void in
                self.cameraButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5) }, completion: nil)
            let outputPath = NSTemporaryDirectory() + "output.mov"
            let outputFileURL = URL(fileURLWithPath: outputPath)
            videoFileOutput?.startRecording(to: outputFileURL, recordingDelegate: self)
        }else{
            isRecording = true
            UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: { ( ) -> Void in
                self.cameraButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0) }, completion: nil)
            cameraButton.layer.removeAllAnimations()
            videoFileOutput?.stopRecording()
        }
        
    }
    
}
extension SimpleVideoCamController:AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        guard error == nil else {
            print(error ?? "")
            return
            
        }
        performSegue(withIdentifier: "playVideo", sender: outputFileURL)
    }
}

