//
//  KeyEvent.swift
//  Keyboards-Training
//
//  Created by Jonas Yang on 2020/12/21.
//

import Foundation
import Combine

protocol KeyCommandPublisher : Publisher {
        
    func next()
    
}

protocol KeyCommandSubscriber: Subscriber {
    
    func onKeyCommand<P>(_ publisher: P, perform action: (P.Output) -> Void) where P: KeyCommandPublisher, P.Failure == Never
}

extension KeyCommandSubscriber {
    typealias Input = String
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        if input != nil {
            return .max(1)
        }
        
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Self.Failure>) {
        
    }
    
}

final class SequencedKeyPublisher: KeyCommandPublisher {
    
    typealias Output = String
    
    typealias Failure = Never
    
    private let subject = PassthroughSubject<String, Never>()
    
    private var currentPosition = 0
    
    func next() {
        let char = currentPosition + 65
        subject.send(String(Character(UnicodeScalar(char)!)))
        self.currentPosition += 1
        self.currentPosition = self.currentPosition % 26
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        self.subject.receive(subscriber: subscriber)
    }
}

final class RandomKeyPublisher: KeyCommandPublisher {
    
    typealias Output = String
    
    typealias Failure = Never
    
    private let subject = PassthroughSubject<String, Never>()
        
    private var currentPosition = 0

    func next() {
        let currentPosition = arc4random() % 26
        let char = 65 + currentPosition
        subject.send(String(Character(UnicodeScalar(char)!)))
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        self.subject.receive(subscriber: subscriber)
    }
}
