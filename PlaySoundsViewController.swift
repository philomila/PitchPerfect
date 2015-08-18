//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Qinhan Jiang on 7/24/15.
//  Copyright (c) 2015 VioletJ. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
            audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    func playAudioWithVariableRate(rate: Float){
        stopPlayingAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changeRate = AVAudioUnitTimePitch()
        changeRate.rate = rate
        audioEngine.attachNode(changeRate)
        
        audioEngine.connect(audioPlayerNode, to: changeRate, format: nil)
        audioEngine.connect(changeRate, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvader(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        stopPlayingAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        var changePitch = AVAudioUnitTimePitch()
        changePitch.pitch = pitch
        audioEngine.attachNode(changePitch)
        
        audioEngine.connect(audioPlayerNode, to: changePitch, format: nil)
        audioEngine.connect(changePitch, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func stopPlayingAudio(){
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopPlayingAudio()
    }

    

}
