//
//  ViewController.swift
//  Scribe
//
//  Created by Brunno Goncalves on 17/11/16.
//  Copyright © 2016 brunnogoncalves. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var trascriptionText: UITextView!
    
    var audioPlayer: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitySpinner.isHidden = true
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
        activitySpinner.isHidden = true

    }
    
    func requestSpeechAuth(){
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    
                    do{
                        
                        let sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self
                        sound.play()
                        
                    } catch{
                        
                        print("Error")
                        
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request){ (result, error) in
                    
                        if let error = error{
                            
                            print(error)
                            
                        } else{
                            
                            if let resultString = result?.bestTranscription.formattedString{
                                
                                self.trascriptionText.text = resultString
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }

    @IBAction func transcribeButtonPressed(_ sender: Any) {
        
        activitySpinner.isHidden = false
        activitySpinner.startAnimating()
        
        requestSpeechAuth()
        
    }

}

