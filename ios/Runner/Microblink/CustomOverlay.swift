//
//  CustomOverlay.swift
//  pdf417-sample-Swift
//
//  Created by Dino Gustin on 06/03/2018.
//  Copyright © 2018 Dino. All rights reserved.
//

import Microblink

class CustomOverlay: MBCustomOverlayViewController, MBScanningRecognizerRunnerViewControllerDelegate,
        MBFirstSideFinishedRecognizerRunnerViewControllerDelegate {
    var result: FlutterResult?
    @IBOutlet weak var tooltipLabel: UILabel!

    static func initFromStoryboard() -> CustomOverlay {

        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomOverlay")

        guard let customOverlay = viewController as? CustomOverlay else {
            fatalError("CustomOverlay should always be an instance of \(CustomOverlay.self) here because we instantiate it from the Storyboard")
        }

        return customOverlay
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.scanningRecognizerRunnerViewControllerDelegate = self
        super.metadataDelegates.firstSideFinishedRecognizerRunnerViewControllerDelegate = self

        self.tooltipLabel.text = "Scan Front Side"
    }

    func recognizerRunnerViewControllerDidFinishScanning(_ recognizerRunnerViewController: UIViewController & MBRecognizerRunnerViewController,
                                                         state: MBRecognizerResultState) {
        // This is done on background thread
        if state == MBRecognizerResultState.valid {
            recognizerRunnerViewController.pauseScanning()

            DispatchQueue.main.async {

                var message: String = ""
                var title: String = ""

                for recognizer in self.recognizerCollection.recognizerList where
                    recognizer.baseResult?.resultState == MBRecognizerResultState.valid {

                    if recognizer is MBBlinkIdRecognizer {
                        let blinkIdRecognizer = recognizer as? MBBlinkIdRecognizer
                        title = "BlinkID"
                        message = (blinkIdRecognizer?.result.description)!
                    }
                    if recognizer is MBBlinkIdCombinedRecognizer {
                        let blinkIdRecognizer = recognizer as? MBBlinkIdCombinedRecognizer
                        title = "BlinkID Combined"
                        message = (blinkIdRecognizer?.result.description)!
                    }
                }
                
                self.result?(message)
                self.dismissScreen()
                
                //let alertController: UIAlertController = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

                //let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default,
                    //                                             handler: { (_) -> Void in
                  //                                                  self.dismiss(animated: true, completion: nil)
                //})
                //alertController.addAction(okAction)
                //self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    func recognizerRunnerViewControllerDidFinishRecognition(ofFirstSide recognizerRunnerViewController: UIViewController & MBRecognizerRunnerViewController) {

        DispatchQueue.main.async {
            self.tooltipLabel.text = "Scan Back Side"
            self.recognizerRunnerViewController?.pauseScanning()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.recognizerRunnerViewController?.resumeScanningAndResetState(false)
            }
        }
    }

    @IBAction func didTapClose(_ sender: Any) {
        self.recognizerRunnerViewController?.overlayViewControllerWillCloseCamera(self)
        dismissScreen()
//        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }

    
    private func dismissScreen() {
        result?(nil)
        presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
