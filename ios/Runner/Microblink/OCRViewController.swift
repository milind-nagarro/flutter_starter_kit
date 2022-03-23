//
//  ViewController.swift
//  BlinkID-sample-Swift
//
//  Created by Dino on 22/12/15.
//  Copyright © 2015 Dino. All rights reserved.
//

import UIKit
import Microblink

class OCRViewController: UIViewController {
    var result: FlutterResult?
    var blinkIdRecognizer: MBBlinkIdCombinedRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        MBMicroblinkSDK.shared().setLicenseKey("sRwAAAETY29tLmJhbmtmYWIubmhsLmFwcDgolUqBLFFdyTMdLXqvt7J5Ig39GVss6vDLMvzWjfOGOyQF/Y8PDiiP1oVdptja7bwKONsBAuDX024uuMbcZkvIYkNK08hoY6Okdan9ZfKD4VKdCxraNtWla/nK3XTBAwm88Qh6npRiq2nhX95tQkUi0Q7Q7Iuutx/Xc6U95lAgRxXW90wunmFQyLv86R9c2vqdTpHbRhy9v5JHEChDavVLiKKksn/2hl0bClo26RUa") { [weak self] err in
            self?.result?(nil)
            self?.dismissScreen()
            debugPrint("error in microblink \(err)")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isBeingPresented || isMovingToParent {
            // This is the first time this instance of the view controller will appear
//            didTapCustomUI()
            didTapScan()
        }
        
    }

    @IBAction func didTapScan() {

        /** Create BlinkID recognizer */
        self.blinkIdRecognizer = MBBlinkIdCombinedRecognizer()
        self.blinkIdRecognizer?.returnFullDocumentImage = true

        /** Create settings */
        let settings: MBBlinkIdOverlaySettings = MBBlinkIdOverlaySettings()

        /** Crate recognizer collection */
        let recognizerList = [self.blinkIdRecognizer!]
        let recognizerCollection: MBRecognizerCollection = MBRecognizerCollection(recognizers: recognizerList)

        /** Create your overlay view controller */
        let blinkIdOverlayViewController: MBBlinkIdOverlayViewController =
            MBBlinkIdOverlayViewController(settings: settings, recognizerCollection: recognizerCollection, delegate: self)

        /** Create recognizer view controller with wanted overlay view controller */
        guard let recognizerRunneViewController: UIViewController =
            MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: blinkIdOverlayViewController) else {
                return
        }
        recognizerRunneViewController.modalPresentationStyle = .fullScreen

        /** Present the recognizer runner view controller. You can use other presentation methods as well (instead of presentViewController) */
        self.present(recognizerRunneViewController, animated: true, completion: nil)
    }

    @IBAction func didTapCustomUI() {

        /** Create BlinkID recognizer */
        self.blinkIdRecognizer = MBBlinkIdCombinedRecognizer()

        /** Crate recognizer collection */
        let recognizerList = [self.blinkIdRecognizer!]
        let recognizerCollection: MBRecognizerCollection = MBRecognizerCollection(recognizers: recognizerList)

        /** Create your overlay view controller */
        let customOverlayViewController: CustomOverlay = CustomOverlay.initFromStoryboard()

        /** This has to be called for custom controller */
        customOverlayViewController.reconfigureRecognizers(recognizerCollection)

        /** Create recognizer view controller with wanted overlay view controller */
        guard let recognizerRunneViewController: UIViewController =
            MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: customOverlayViewController) else {
                return
        }

        recognizerRunneViewController.modalPresentationStyle = .fullScreen
        customOverlayViewController.result = result
        /** Present the recognizer runner view controller. You can use other presentation methods as well (instead of presentViewController) */
        self.present(recognizerRunneViewController, animated: false, completion: nil)
    }
}

extension OCRViewController: MBBlinkIdOverlayViewControllerDelegate {

    func blinkIdOverlayViewControllerDidFinishScanning(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController, state: MBRecognizerResultState) {
        /** This is done on background thread */
        blinkIdOverlayViewController.recognizerRunnerViewController?.pauseScanning()

        var message: String = ""

        if blinkIdRecognizer?.result.resultState == MBRecognizerResultState.valid {

            // Save the string representation of the code
            message = blinkIdRecognizer!.result.description
            var dict = [String: String]()
            if let fullName = blinkIdRecognizer!.result.fullName {
                dict["Name"] = fullName
            }
            if let gender = blinkIdRecognizer!.result.sex {
                dict["Gender"] = gender
            }
            if let dob = blinkIdRecognizer!.result.dateOfBirth {
                dict["Date of birth"] = "\(dob.day)/\(dob.month)/\(dob.year)"
            }
            if let doexp = blinkIdRecognizer!.result.dateOfExpiry {
                dict["ID expiry date"] = "\(doexp.day)/\(doexp.month)/\(doexp.year)"
            }
            if let mrzRes = blinkIdRecognizer!.result.mrzResult {
                dict["Nationality"] = mrzRes.nationalityName
            }
            
            
            /** Needs to be called on main thread beacuse everything prior is on background thread */
            DispatchQueue.main.async { [weak self] in
                // present the alert view with scanned results
                self?.result?("\(dict as AnyObject)")
//                self?.result?(message)
                self?.dismissScreen()
                
            }
        }
    }

    func blinkIdOverlayViewControllerDidTapClose(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController) {
        result?(nil)
        dismissScreen()
    }
    
    func dismissScreen() {
        presentingViewController?.dismiss(animated: false)
    }
}
