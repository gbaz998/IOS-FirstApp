import Foundation
import AVFoundation
import Speech

final class SoundManager: NSObject {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    private let session = AVAudioSession.sharedInstance()

    // Speech
    private let speechRecognizer = SFSpeechRecognizer()
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var keyword: String?
    var onKeyword: (() -> Void)?

    func loadSFX(named: String = "reward", ext: String = "wav") {
        guard let url = Bundle.main.url(forResource: named, withExtension: ext) else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
        } catch { print("SFX error:", error) }
    }
    func playSFX() { player?.play() }

    // MARK: Speech
    func prepareSpeech() {
        SFSpeechRecognizer.requestAuthorization { _ in }
        AVAudioApplication.requestRecordPermission { _ in }
    }
    func startListening(keyword: String) {
        self.keyword = keyword.lowercased()
        if audioEngine.isRunning { stopListening() }
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let request = recognitionRequest else { return }
        request.shouldReportPartialResults = true

        let node = audioEngine.inputNode
        let format = node.outputFormat(forBus: 0)
        node.removeTap(onBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: format) { [weak self] buf, _ in
            self?.recognitionRequest?.append(buf)
        }
        audioEngine.prepare(); try? audioEngine.start()

        recognitionTask = speechRecognizer?.recognitionTask(with: request) { [weak self] result, error in
            guard error == nil else { return }
            if let text = result?.bestTranscription.formattedString.lowercased(),
               let key = self?.keyword, text.contains(key) {
                self?.onKeyword?()
            }
        }
    }
    func stopListening() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()
        recognitionRequest = nil; recognitionTask = nil
    }
}
