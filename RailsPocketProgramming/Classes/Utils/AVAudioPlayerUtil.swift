import AVFoundation

struct AVAudioPlayerUtil {
    
    static var audioPlayer:AVAudioPlayer = AVAudioPlayer();
    static var audioData:NSURL = NSURL();
    
    static func setValue(audioFile:String){
        self.audioData = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(audioFile, ofType: "mp3", inDirectory: "Audio")!)
        do {                    
            try self.audioPlayer = AVAudioPlayer(contentsOfURL: self.audioData);
        } catch {
            print("audio error")
        }
        self.audioPlayer.prepareToPlay();
    }
    
    static func play(){
        self.audioPlayer.play();
    }
}