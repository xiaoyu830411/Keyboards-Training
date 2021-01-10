
//
//  KeyEvent.swift
//  Keyboards-Training
//
//  Created by Jonas Yang on 2020/12/21.
//

import Foundation

protocol KeyCommandListener {
    
    func receive(_ event: KeyEvent)
}

class KeyCommandPublisher {
    var listeners = [KeyCommandListener]()
    
    func addListener(_ listener: KeyCommandListener) {
        listeners.append(listener)
    }
    
    func send(event: KeyEvent) {
        for listener in listeners {
            listener.receive(event)
        }
    }
}

protocol Nexter {
    func next()
}

enum KeyEvent {
    case Exception(key: String), Inputted(key: String)
}

final class SequencedKeyPublisher: KeyCommandPublisher, Nexter {
        
    private var currentPosition = 0
    
    func next() {
        let char = currentPosition + 65
        self.send(event: KeyEvent.Exception(key: String(Character(UnicodeScalar(char)!))))
        self.currentPosition += 1
        self.currentPosition = self.currentPosition % 26
    }
    
}

final class RandomKeyPublisher: KeyCommandPublisher, Nexter {
        
    private var currentPosition = 0

    func next() {
        let currentPosition = arc4random() % 26
        let char = 65 + currentPosition
        self.send(event: KeyEvent.Exception(key: String(Character(UnicodeScalar(char)!))))
    }
}

final class KeyNexter: Nexter, KeyCommandListener {
    var key = ""
    var exception: Nexter
    
    init(exception: Nexter) {
        self.exception = exception
    }
    
    func receive(_ event: KeyEvent) {
        switch event {
        case .Inputted(let key) :
            if self.key == key {
                exception.next()
            }
        default:
            return
        }
    }
    
    func next() {
        self.exception.next()
    }
}

final class InputtedKeyPubliser: KeyCommandPublisher, Nexter {
    func next() {
        <#code#>
    }
    
    
}
