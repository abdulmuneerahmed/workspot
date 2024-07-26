//
//  Coordinator.swift
//  WorkSpot
//
//  Created by Abdul Muneer Ahmed on 25/07/24.
//

import SwiftUI
import AVFoundation


class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {

    @Binding var scanResult: String

    init(_ scanResult: Binding<String>) {
        self._scanResult = scanResult
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            scanResult = "No QR code detected"
            return
        }

        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject

        if metadataObj.type == AVMetadataObject.ObjectType.qr,
           let result = metadataObj.stringValue {

            scanResult = result

        }
    }
}
