//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Nilay Jain on 24/11/24.
//

import Foundation
import AVFoundation
import UIKit

enum CameraErorr: Error {
    case invalidDeviceInput = "Something went wrong with the device input"
    case invalidScannedValue = "The value scanned is nit valid"
}

protocol ScannerVCDelegate: AnyObject{
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}


final class ScannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
    private func setupCaptureSession() {
            
            guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
                return }
         
                let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)

            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metadataOutput.metadataObjectTypes = [.ean8, .ean13]
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
        
        
            }
        }

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else{
            scannerDelegate?.didSurface(error: .invalidScannedValue)
      return
        }
        
            guard let machineReadableCode = object as? AVMetadataMachineReadableCodeObject else{
                scannerDelegate?.didSurface(error: .invalidScannedValue)
        return }
        
        guard let barcode = machineReadableCode.stringValue else{
            scannerDelegate?.didSurface(error: .invalidScannedValue)

        return }
        
        scannerDelegate?.didFind(barcode: barcode)    }
}
    

    

    
    

